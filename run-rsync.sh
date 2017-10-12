#!/bin/bash
#
echo "#processing /mnt/nCore/nCore/ to /mnt/nCore/mediaFiles/"
##processing /mnt/nCore/nCore/ to /mnt/RAID/mediaFiles/ (copy)
filebot -script fn:amc --output "/mnt/nCore/mediaFiles/" --action copy --conflict auto -non-strict "/mnt/nCore/nCore/" --log-file amc.log --def  music=y  unsorted=y clean=y storeReport=y artwork=y extras=y subtitles=en excludeList=nCore2mediaFilesNew.txt --def movieFormat="Movies/{ny}/{ny}{' CD'+pi}{subt} - {resolution} - {source} - {audio.language}" seriesFormat="TV Shows/{n}/{'Season '+s}/{n} - {s00e00} - {t} - {resolution} - {source} - {audio.language}" animeFormat="Anime/{ny}/{ny}{' CD'+pi}{subt} - {resolution} - {source} - {audio.language}" musicFormat="Music/{n}/{album+'/'}{pi.pad(2)+'. '} {t} {[media.overallBitRateString]}" --db TheMovieDB
#
musicFolderMv () {
tFolder="/mnt/nCore/mediaFiles/Music"
fNames=( 0-9 abc def ghi jkl mno pqr stu vwx yz äöü @ )
mNames=( 0-9 a-cA-C d-fD-F g-iG-I j-lJ-L m-oM-O p-rP-R s-uS-U v-xV-X y-zY-Z äöüÄÖÜ @Í[ )
#
for ((i = 0; i < ${#fNames[@]}; ++i)); do
	mkdir -p $tFolder/${fNames[$i]}
	mv $tFolder/[${mNames[$i]}]* $tFolder/${fNames[$i]}
done
echo "musicFolderMv DONE"
}
#
musicFolderMv
#echo "#copy metadata to /mnt/RAID/metadata"
#rsync -vArum --delete-delay --exclude-from 'exclude-list.txt' --log-file=/home/ibrahim/metadataRAID.txt /mnt/RAID/mediaFiles/* /mnt/RAID/metadata/
#
#echo "#--dry-run copy from nCore to /mnt/RAID/mediaFiles/"
#rsync -vArum --delete-delay --dry-run --log-file=/home/ibrahim/nCoreMediaFiles.txt /mnt/nCore/mediaFiles/* /mnt/RAID/mediaFiles/
#
#echo "#--dry-run copy from my-pc to /mnt/RAID/mediaFiles/"
#rsync -vArum --delete-delay --log-file=/home/ibrahim/mediaFiles.txt /net/my-pc/mediaFiles/* /mnt/mdrive/mediaFiles/
#rsync -vArum --delete-delay --dry-run --log-file=/home/ibrahim/mediaFiles.txt /net/my-pc/mediaFiles/* /mnt/RAID/mediaFiles/
#rsync -vArum --delete-delay --dry-run --log-file=/home/ibrahim/mediaFilesSW.txt /net/my-pc/software/* /mnt/RAID/Software/
#
echo "#set permissions on /mnt/nCore/mediaFiles/"
chown ibrahim:mediaServer /mnt/nCore/mediaFiles/ -R
chmod 755 /mnt/nCore/mediaFiles/ -R
#
echo "#running find and chmod on nCore"
find /mnt/nCore/mediaFiles/ -type f -exec chmod 644 {} \;
#

echo "#copy from nCore to /mnt/RAID/mediaFiles/"
rsync -vArum --delete-before --log-file=/home/ibrahim/nCoreMediaFiles.txt /mnt/nCore/mediaFiles/* /mnt/RAID/mediaFiles/
#rsync -vArum --delete-delay --log-file=/home/ibrahim/mediaFiles.txt /net/my-pc/mediaFiles/* /mnt/mdrive/mediaFiles/
#rsync -vArum --delete-delay --log-file=/home/ibrahim/mediaFiles.txt /net/my-pc/mediaFiles/* /mnt/RAID/mediaFiles/
#rsync -vArum --delete-delay --log-file=/home/ibrahim/mediaFilesSW.txt /net/my-pc/software/* /mnt/RAID/Software/
#
#echo "#set permissions on /mnt/mdrive/"
#chown ibrahim:mediaServer /mnt/mdrive/mediaFiles/ -R;
#chown ibrahim:mediaServer /mnt/mdrive/metadata/ -R;
#chmod 755 /mnt/mdrive/ -R;
#find /mnt/mdrive/ -type d -name \* -exec chmod 775 {} \;
#find /mnt/mdrive/ -type f -exec chmod 644 {} \;
#
echo "#set permissions on /mnt/RAID/mediaFiles/"
chown ibrahim:mediaServer /mnt/RAID/mediaFiles/ -R
#chown ibrahim:mediaServer /mnt/RAID/metadata/ -R
#chown ibrahim:ibrahim /mnt/RAID/Software/ -R
#chown emby:emby /mnt/RAID/Emby/ -R
chmod 755 /mnt/RAID/mediaFiles/ -R
#
echo "#running find and chmod"
#find /mnt/RAID/ -type d -name \* -exec chmod 775 {} \;
find /mnt/RAID/mediaFiles/ -type f -exec chmod 644 {} \;
#
#echo "#merge mediaFiles with metadata on /mnt/RAID/"
#rsync -vru --dry-run --log-file=/home/ibrahim/metadataRAID.txt /mnt/mdrive/metadata/* /mnt/RAID/
#rsync -vru --dry-run --log-file=/home/ibrahim/mediaFilesRAID.txt /mnt/mdrive/mediaFiles/* /mnt/RAID/
#
echo "#DONE"
