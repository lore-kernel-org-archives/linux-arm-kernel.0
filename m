From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Tue, 22 Jan 2013 13:19:33 +0100
Subject: OMAP baseline test results for v3.8-rc4
In-Reply-To: <20130122095218.GD2637@n2100.arm.linux.org.uk> (Russell King's
 message of "Tue, 22 Jan 2013 09:52:18 +0000")
References: <alpine.DEB.2.00.1301202136290.31667@utopia.booyaka.com>
 <50FD6D8D.6030106@mimc.co.uk> <20130121164510.GA18905@kahuna>
 <f36acfaf128c4844b8f696ea4440e253@DLEE74.ent.ti.com>
 <20130121182419.GE10020@beef> <87boci9str.fsf@dell.be.48ers.dk>
 <alpine.DEB.2.00.1301220213390.25789@utopia.booyaka.com>
 <1358846666.3996.3.camel@coredoba.hi.pengutronix.de>
 <87ham95zdt.fsf@dell.be.48ers.dk>
 <20130122095218.GD2637@n2100.arm.linux.org.uk>
Message-ID: <878v7l5s16.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Russell" == Russell King <- ARM Linux <linux@arm.linux.org.uk>> writes:

 Russell> Don't rely on that.  Remember, if the compressed image
 Russell> occupies the same location as the decompressed kernel, the
 Russell> decompressor will copy the data to a different location in RAM
 Russell> first - I think at RAM offset + 32K + decompressed kernel
 Russell> size.

Ok, but this is with the exact same kernel image loaded at the same
address for the two cases. The only difference is U-Boot version.

 Russell> So yes, please try the patch in the link above.

I did. No visible difference. Also not with changing the uImage load
address (2M/16M/32M from start of RAM).

-- 
Bye, Peter Korsgaard
