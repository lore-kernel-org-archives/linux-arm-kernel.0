From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 1 Oct 2015 15:09:32 +0200
Subject: [linux-sunxi][PATCH v5] ARM: sun7i: dt: Add new Olimex A20 EVB
 device
In-Reply-To: <CAEKpxB=ytV17o5uO6srDbJSrvNe66EeRERF-Ow=HuzE4=z1qag@mail.gmail.com>
References: <1443634479-18111-1-git-send-email-codekipper@gmail.com>
 <20151001120630.GH7104@lukather>
 <CAEKpxB=ytV17o5uO6srDbJSrvNe66EeRERF-Ow=HuzE4=z1qag@mail.gmail.com>
Message-ID: <20151001130932.GJ7104@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 01, 2015 at 02:54:07PM +0200, Code Kipper wrote:
> >> +&reg_dcdc2 {
> >> +     regulator-always-on;
> >> +     regulator-min-microvolt = <1000000>;
> >> +     regulator-max-microvolt = <1425000>;
> >
> > You also changed that since v4, for an unknown reason, and without
> > mentionning it in the changelog...
>
> AAARRRGGGGHHHHHHHHHHH....could you kindly fix this for me?....pllllleeeasseee.

If that's the only change you made, sure...

But you should pay more attention and / or polish your git
workflow. Having part of codes from several versions ago poping back
is definitely not good.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151001/33dbb9bf/attachment.sig>
