From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 22 Nov 2015 20:46:43 +0100
Subject: [PATCH v3 5/9] ARM: dts: sun8i: sinlinx-sina33: Add AXP223 PMIC
 device and regulator nodes
In-Reply-To: <CAGb2v67RxuQT4AffPbdW29yLMn7jjHgiqwXTGmgf8VgqT-fN9g@mail.gmail.com>
References: <1447691908-25456-1-git-send-email-wens@csie.org>
 <1447691908-25456-6-git-send-email-wens@csie.org>
 <20151120111238.GV32142@lukather>
 <CAGb2v67RxuQT4AffPbdW29yLMn7jjHgiqwXTGmgf8VgqT-fN9g@mail.gmail.com>
Message-ID: <20151122194643.GP32142@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 21, 2015 at 01:24:24AM +0800, Chen-Yu Tsai wrote:
> >> +&reg_rtc_ldo {
> >> +     regulator-always-on;
> >> +     regulator-min-microvolt = <3000000>;
> >> +     regulator-max-microvolt = <3000000>;
> >> +     regulator-name = "vcc-rtc";
> >>  };
> >
> > Isn't this supposed to be in the AXP DTSI?
> 
> Are you referring to &reg_rtc_ldo?

Yep :)

> Yes, it should. I'll do a new version.

Great, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151122/6734c65a/attachment.sig>
