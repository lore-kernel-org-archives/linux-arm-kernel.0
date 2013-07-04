From: balbi@ti.com (Felipe Balbi)
Date: Thu, 4 Jul 2013 20:41:27 +0300
Subject: OMAP baseline test results for v3.10-rc7
In-Reply-To: <alpine.DEB.2.02.1307041650170.6258@utopia.booyaka.com>
References: <alpine.DEB.2.02.1307011946180.4358@utopia.booyaka.com>
 <20130701204236.GA805@arwen.pp.htv.fi>
 <alpine.DEB.2.02.1307041650170.6258@utopia.booyaka.com>
Message-ID: <20130704174127.GC6687@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 04, 2013 at 05:11:33PM +0000, Paul Walmsley wrote:
> Hi
> 
> On Mon, 1 Jul 2013, Felipe Balbi wrote:
> 
> > On Mon, Jul 01, 2013 at 07:48:50PM +0000, Paul Walmsley wrote:
> > > Boot to userspace:
> > >     FAIL ( 2/12): 37xxevm, am335xbonelt
> > 
> > <quoting part of [1]>
> > | U-Boot# tftp 0x82000000 am335x-boneblack.dtb
> > | link up on port 0, speed 100, full duplex
> > | Using cpsw device
> > | TFTP from server 192.168.57.1; our IP address is 192.168.57.138
> > | Filename 'am335x-boneblack.dtb'.
> > 
> > Where are you taking am335x-boneblack.dtb from ? It's not in mainline
> > v3.10-rc7 kernel:
> 
> As mentioned in my earlier reply:
> 
> http://www.spinics.net/lists/arm-kernel/msg255055.html
> 
> my earlier test boots were with the am335x-boneblack.dtb from the 
> ti-linux-3.8.y tree from Vaibhav's github, since that was the only DTB 
> that I was able to get any kernel to boot with.
> 
> The am33xx_only/appended DTB issues don't apply to this board since it's 
> booted with detached DTB and omap2plus_defconfig.
> 
> Anyway, just retried it with the mainline am335x-bone.dtb file with v3.10, 
> and the board comes up now.  So that's good, will switch to 
> am335x-bone.dtb for the testing restate jobs to be run for 
> BeagleBone-white, and let's see what previous kernels it boots with now...

alright

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130704/e36ba507/attachment.sig>
