From: ibr@radix50.net (Baurzhan Ismagulov)
Date: Tue, 22 Mar 2011 12:21:18 +0100
Subject: [Q] Booting kernel from NFS?
In-Reply-To: <201103201612142509289@gmail.com>
References: <201008080921466561614@gmail.com> <201103201612142509289@gmail.com>
Message-ID: <20110322112118.GD5456@radix50.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 20, 2011 at 04:13:04PM +0800, Chen Wenjie wrote:
> 	I am debuging some issues on an arm-arch board. 
> now, I have to compile the whole kernel, download zImage to the target board 
> and reboot the board again and again. Since the relations between the 
> source files are complex, it is difficult to just write a module for insmod/rmmod.
> 
> 	My question is: is there any way to boot the kernel from NFS? so we can 
> use zImage on the host machine through an ethernet/USB cable. Then we needn't 
> download the zImage file to the target board when we debug it.
>                                                            	
> 	Is there any bootloader with this feature? Any comments?
> (now I use bootloader LK("Little Kernel"))

U-Boot can download the kernel over TFTP.

With kind regards,
-- 
Baurzhan Ismagulov
http://www.kz-easy.com/
