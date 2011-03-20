From: ccc.cwj@gmail.com (=?utf-8?B?Q2hlbiBXZW5qaWU=?=)
Date: Sun, 20 Mar 2011 16:13:04 +0800
Subject: =?utf-8?B?W1FdIEJvb3Rpbmcga2VybmVsIGZyb20gTkZTPw==?=
References: <loom.20100806T201947-76@post.gmane.org>,
	<201008080921466561614@gmail.com>
Message-ID: <201103201612142509289@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Experts!

	I am debuging some issues on an arm-arch board. 
now, I have to compile the whole kernel, download zImage to the target board 
and reboot the board again and again. Since the relations between the 
source files are complex, it is difficult to just write a module for insmod/rmmod.

	My question is: is there any way to boot the kernel from NFS? so we can 
use zImage on the host machine through an ethernet/USB cable. Then we needn't 
download the zImage file to the target board when we debug it.
                                                           	
	Is there any bootloader with this feature? Any comments?
(now I use bootloader LK("Little Kernel"))

	Thank you!


Wenjie
