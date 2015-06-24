From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 24 Jun 2015 22:25:56 +0200
Subject: [PATCH 2/2] ARM: dts: mediatek: add mt6580 basic support
In-Reply-To: <1435147153.3792.9.camel@mtkswgap22>
References: <1433319533-24803-1-git-send-email-mars.cheng@mediatek.com>
 <3799922.TWv12CPu81@ubix> <1435147153.3792.9.camel@mtkswgap22>
Message-ID: <2753320.5M4yQIm8Im@ubix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, June 24, 2015 07:59:13 PM Mars Cheng wrote:
> On Tue, 2015-06-23 at 21:45 +0200, Matthias Brugger wrote:
> > > +	soc {
> > 
> > Please drop the soc node as well and just add the components directly.
> > 
> > Thanks,
> > Matthias
> 
> May I know the reason to remove the soc node? I follow other xxxx.dtsi
> to add this node.

The device tree is reflecting the hardware, if you add a soc node like this, it 
is seen like a bus, but there is not really a bus.

I think point of view about this has change over time and nowadays it is 
preferred not to add a soc node.

Regards,
Matthias
