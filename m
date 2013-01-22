From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Tue, 22 Jan 2013 13:21:21 +0100
Subject: OMAP baseline test results for v3.8-rc4
In-Reply-To: <50FE66AC.2090306@mimc.co.uk> (Mark Jackson's message of "Tue, 22
 Jan 2013 10:15:08 +0000")
References: <alpine.DEB.2.00.1301202136290.31667@utopia.booyaka.com>
 <50FD6D8D.6030106@mimc.co.uk> <20130121164510.GA18905@kahuna>
 <f36acfaf128c4844b8f696ea4440e253@DLEE74.ent.ti.com>
 <20130121182419.GE10020@beef> <87boci9str.fsf@dell.be.48ers.dk>
 <alpine.DEB.2.00.1301220213390.25789@utopia.booyaka.com>
 <50FE66AC.2090306@mimc.co.uk>
Message-ID: <874ni95ry6.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Mark" == Mark Jackson <mpfj-list@mimc.co.uk> writes:

Hi,

 Mark> Bytes transferred = 3963919 (3c7c0f hex)
 Mark> ## Booting kernel from Legacy Image at 80000000 ...
 Mark>    Image Name:   Linux
 Mark>    Image Type:   ARM Linux Kernel Image (uncompressed)
 Mark>    Data Size:    3963855 Bytes = 3.8 MiB
 Mark>    Load Address: 80008000
 Mark>    Entry Point:  80008000
 Mark>    Verifying Checksum ... OK
 Mark>    Loading Kernel Image ... OK
 Mark> OK

I haven't tried a recent -next build, but what is your kernel command
line and did you try without EARLY_PRINTK?

-- 
Bye, Peter Korsgaard
