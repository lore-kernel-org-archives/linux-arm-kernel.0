From: vanessa.maegima@nxp.com (Vanessa Maegima)
Date: Fri, 10 Nov 2017 12:38:57 +0000
Subject: [PATCH] ARM: dts: imx7d-pico-pi: Separate into cpu and baseboard
 dts
In-Reply-To: <CAP9ODKrNzLkOt76=b58S3TioXBk1FrS4XpPkPQCN48mcAP-GVQ@mail.gmail.com>
References: <1510079483-24012-1-git-send-email-vanessa.maegima@nxp.com>
 <CAP9ODKrNzLkOt76=b58S3TioXBk1FrS4XpPkPQCN48mcAP-GVQ@mail.gmail.com>
Message-ID: <1510317495.12715.2.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Ter, 2017-11-07 at 18:05 -0200, Otavio Salvador wrote:
> On Tue, Nov 7, 2017 at 4:31 PM, Vanessa Maegima <vanessa.maegima@nxp.
> com> wrote:
> > 
> > Separate the old imx7d-pico into cpu (imx7d-pico.dtsi) and
> > baseboard
> > (imx7d-pico-pi.dts) dts so the same cpu dtsi can be used in
> > different
> > baseboards variants.
> > 
> > Signed-off-by: Vanessa Maegima <vanessa.maegima@nxp.com>
> Thanks for looking at this Vanessa, one question though is if it is
> allowed to just drop the old dtb file or we need to keep it for
> backward compatibility?
> 
> Honestly, it was not available for a long time so I would personally
> be fine with just renaming it but I don't know about the police on
> this.
> 

I do not know this either, but I agree with you, just renaming it seems
ok for me.

Vanessa
