From: xiachendong@hotmail.com (Xiachen Dong)
Date: Mon, 28 Jun 2010 16:39:07 -0400
Subject: Flash write endurance (write cycle) test for AT91RM9200 boards
Message-ID: <BAY134-W19D664FC2A596F0209D21FBDCA0@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

We use AT91RM9200 MCU and made our own motherboard for it. We wish to know how many write cycles the flash (MicroSD and DataFlash) may survive under both OS and non-OS situation. We also wish to know the behavior of the flash when the flash becomes dead.

After doing some searching on the web, we found the following information helpful:

1) Write Endurance in Flash Drives: Measurements and Analysis
http://www.ccs.neu.edu/home/pjd/papers/fast10-flash.pdf

2) NAND Testing
http://wiki.laptop.org/go/NAND_Testing

3) How Long Does a Flash Drive Last?
http://www.bress.net/blog/archives/114-How-Long-Does-a-Flash-Drive-Last.html

What we plan to do is to test the flash both under u-boot (raw, without JFFS2) and Linux OS (with ext2 fs). The test will be done with flash empty and flash full. We will also do the test under different room temperatures.

We searched the archive of the list. It looks like no posts mentioned such tests. We wonder anyone on the list has done similar test before and are there any special attention need to pay while doing such tests. Are there any professional software (either open source or commercial) for such tests? Any suggestions and comments are welcomed.

Thanks,

Xiachen

 		 	   		  
_________________________________________________________________
Turn down-time into play-time with Messenger games
http://go.microsoft.com/?linkid=9734385
