From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Mon, 21 Jan 2013 21:36:32 +0100
Subject: OMAP baseline test results for v3.8-rc4
In-Reply-To: <20130121182419.GE10020@beef> (Matt Porter's message of "Mon, 21
 Jan 2013 13:24:19 -0500")
References: <alpine.DEB.2.00.1301202136290.31667@utopia.booyaka.com>
 <50FD6D8D.6030106@mimc.co.uk> <20130121164510.GA18905@kahuna>
 <f36acfaf128c4844b8f696ea4440e253@DLEE74.ent.ti.com>
 <20130121182419.GE10020@beef>
Message-ID: <87boci9str.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Matt" == Matt Porter <mporter@ti.com> writes:

 Matt> On Mon, Jan 21, 2013 at 06:20:03PM +0000, Richard Cochran wrote:
 >> On Mon, Jan 21, 2013 at 10:45:10AM -0600, Nishanth Menon wrote:
 >> > for MMC filesystem - we need the edma series. for a ramdisk, I am able
 >> > to boot up to shell with 3.8-rc4 tag
 >> 
 >> Yep, I also could boot 3.8-rc3 using ramfs, no problem.

 Matt> Do you use appended dtb? The only different that jumped out at me first
 Matt> Paul's reported hang is he uses appended dtb and I boot my boards with a
 Matt> single uImage and multiple dtbs the traditional DT way.

It works for me with appended dtb as well.

-- 
Bye, Peter Korsgaard
