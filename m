From: mpfj-list@mimc.co.uk (Mark Jackson)
Date: Tue, 22 Jan 2013 13:45:55 +0000
Subject: OMAP baseline test results for v3.8-rc4
In-Reply-To: <874ni95ry6.fsf@dell.be.48ers.dk>
References: <alpine.DEB.2.00.1301202136290.31667@utopia.booyaka.com>
 <50FD6D8D.6030106@mimc.co.uk> <20130121164510.GA18905@kahuna>
 <f36acfaf128c4844b8f696ea4440e253@DLEE74.ent.ti.com>
 <20130121182419.GE10020@beef> <87boci9str.fsf@dell.be.48ers.dk>
 <alpine.DEB.2.00.1301220213390.25789@utopia.booyaka.com>
 <50FE66AC.2090306@mimc.co.uk> <874ni95ry6.fsf@dell.be.48ers.dk>
Message-ID: <50FE9813.8060207@mimc.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/01/13 12:21, Peter Korsgaard wrote:
>>>>>> "Mark" == Mark Jackson <mpfj-list@mimc.co.uk> writes:
> 
> Hi,
> 
>  Mark> Bytes transferred = 3963919 (3c7c0f hex)
>  Mark> ## Booting kernel from Legacy Image at 80000000 ...
>  Mark>    Image Name:   Linux
>  Mark>    Image Type:   ARM Linux Kernel Image (uncompressed)
>  Mark>    Data Size:    3963855 Bytes = 3.8 MiB
>  Mark>    Load Address: 80008000
>  Mark>    Entry Point:  80008000
>  Mark>    Verifying Checksum ... OK
>  Mark>    Loading Kernel Image ... OK
>  Mark> OK
> 
> I haven't tried a recent -next build, but what is your kernel command
> line and did you try without EARLY_PRINTK?
> 

Kernel command line: console=ttyO0,115200n8 earlyprintk debug root=/dev/mmcblk0p2 ro rootfstype=ext2
rootwait

I understand that MMC is not in the mainline.

Aha ... I tried without EARLY_PRINTK and it now boots up to the point of rootfs access.

Cheers
Mark J.
