From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Thu, 09 Dec 2010 09:21:19 +0000
Subject: [PATCHv3] support PMIC mc13892
In-Reply-To: <AANLkTinAmxdoy2mXqDEOPrkKk4BwLefF=7GNAGwZQz=N@mail.gmail.com>
References: <1291778460-22819-1-git-send-email-yong.shen@freescale.com>
	<1291778460-22819-2-git-send-email-yong.shen@freescale.com>
	<AANLkTim-_Xft9b0D3PfG8bC6_m4Kp0GtC8ZwW-NEp5-0@mail.gmail.com>
	<1291812851.3260.189.camel@odin>
	<AANLkTinAmxdoy2mXqDEOPrkKk4BwLefF=7GNAGwZQz=N@mail.gmail.com>
Message-ID: <1291886479.3271.11.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-12-09 at 13:13 +0800, Yong Shen wrote:
> Hi Sascha and Uwe,
> 
> On Wed, Dec 8, 2010 at 8:54 PM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> > On Wed, 2010-12-08 at 11:28 +0800, Yong Shen wrote:
> >> Hi Liam,
> >>
> >> Last time, you took the previous patches for mc13783 code
> >> reorganization in your tree,
> >
> > I've not applied this yet, I'm waiting on an Ack from either Sascha or
> > Uwe regarding the arch mxc changes in this patch.
> >
> It seems that Liam is waiting for an ack from you about previous
> mc13783 patch. I am not sure about the arch mxc changes he mentioned,
> could you please feedback on this?
> 

Fwiw, it's always better to send a reply to all on the same thread as
your previous patch when discussing the previous patch. That way people
will have a better idea of the patch being discussed.

Your previous patch did have some changes to some files under
arch/arm/mach-mxc and it's good practice to get either Sascha's or Uwe's
Ack on those changes before they are applied via the regulator tree.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
