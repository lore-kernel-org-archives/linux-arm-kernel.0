From: mars.cheng@mediatek.com (Mars Cheng)
Date: Thu, 2 Jul 2015 11:29:01 +0800
Subject: [PATCH 2/2] ARM: dts: mediatek: add mt6580 basic support
In-Reply-To: <1435191308.28046.1.camel@mtkswgap22>
References: <1433319533-24803-1-git-send-email-mars.cheng@mediatek.com>
 <3799922.TWv12CPu81@ubix> <1435147153.3792.9.camel@mtkswgap22>
 <2753320.5M4yQIm8Im@ubix> <1435191308.28046.1.camel@mtkswgap22>
Message-ID: <1435807741.28791.6.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias

May I double confirm with you that soc node is MUST removed?
If yes, we will upstream dtsi with this format for other new chips.

Thanks.

On Thu, 2015-06-25 at 08:15 +0800, Mars Cheng wrote:
> On Wed, 2015-06-24 at 22:25 +0200, Matthias Brugger wrote:
> > On Wednesday, June 24, 2015 07:59:13 PM Mars Cheng wrote:
> > > On Tue, 2015-06-23 at 21:45 +0200, Matthias Brugger wrote:
> > > > > +	soc {
> > > > 
> > > > Please drop the soc node as well and just add the components directly.
> > > > 
> > > > Thanks,
> > > > Matthias
> > > 
> > > May I know the reason to remove the soc node? I follow other xxxx.dtsi
> > > to add this node.
> > 
> > The device tree is reflecting the hardware, if you add a soc node like this, it 
> > is seen like a bus, but there is not really a bus.
> > 
> > I think point of view about this has change over time and nowadays it is 
> > preferred not to add a soc node.
> > 
> > Regards,
> > Matthias
> Got it. Will remove the soc node and prepare the new patch.
> 
> Thanks a lot.
> 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
