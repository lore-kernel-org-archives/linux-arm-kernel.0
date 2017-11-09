From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 9 Nov 2017 14:40:32 +0100
Subject: [PATCH 1/1] add mali r6p2 dt node
In-Reply-To: <49715d2b-97f5-7e21-7072-8e050d471a9f@micronovasrl.com>
References: <1510049010-5758-1-git-send-email-giulio.benetti@micronovasrl.com>
 <20171107110539.3wrm6uu6ohh6dnuy@flea>
 <49715d2b-97f5-7e21-7072-8e050d471a9f@micronovasrl.com>
Message-ID: <20171109134032.rwhhf6pvcr6xrgol@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 07, 2017 at 06:55:22PM +0100, Giulio Benetti wrote:
> Hi,
> 
> Il 07/11/2017 12:05, Maxime Ripard ha scritto:
> > Hi,
> > 
> > On Tue, Nov 07, 2017 at 11:03:30AM +0100, Giulio Benetti wrote:
> > > This patch adds device tree mali node compatible with r6p2 utgard kernel driver
> > > provided by ARM and patched by maxime ripard on his github.
> > > 
> > > It can be easily used in target.dts with:
> > > 
> > > &mali {
> > > 	status = "okay";
> > > }
> > > 
> > > then loading mali.ko in user space.
> > > 
> > > Best regards
> > > Giulio Benetti
> > > Micronova srl
> > 
> > Again, you should have a proper commit log here.
> 
> As log could it be:
> It seems there is not mali node in sun7i-a20.dtsi    << This is "Why"
> 
> Add mali node to sun7i-a20.dtsi                << This is "How"
> 
> Or can you point me to some example?
> I've tried to check lot of other patches,
> but really I can't understand which is the right way.

Not having your signature would be a good start, and describing the
changes would be great as well. You can comment on which Mali chip it
is for example, which variant, whether the BSP uses thermal throttling
or not, and if so why did you leave it out, which frequency it's
running at, etc.

> Now, to avoid any possible other mistake,
> do I have to resubmit patch corrected answering to this thread,
> when you give me the ok?

Please resend it yes.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171109/2432e33d/attachment.sig>
