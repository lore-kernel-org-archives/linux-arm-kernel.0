From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 25 Sep 2018 11:01:39 +0200
Subject: [PATCH 1/2] arm64: dts: allwinner: Olimex A64-OLinuXino: enable
 eMMC.
In-Reply-To: <CAG7TQgE_KU_cK_4E+NG8Qcw-QB2=C6YoqBYR2svmWxywFyySCw@mail.gmail.com>
References: <20180919141815.18737-1-rodrigo@tjader.xyz>
 <20180921142811.h5jraemk565alh3i@flea>
 <CAG7TQgE_KU_cK_4E+NG8Qcw-QB2=C6YoqBYR2svmWxywFyySCw@mail.gmail.com>
Message-ID: <20180925090139.qbu6tqav5oth7zkw@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2018 at 11:54:07AM -0300, Rodrigo Exterck?tter Tj?der wrote:
> On Fri, Sep 21, 2018 at 11:28 AM Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > Expanding a bit more that commit log would be helpful. What is the
> > eMMC connected to that board? Do all versions have it? Which modes are
> > supposed to be supported, and which one have been tested?
> 
> The terseness of the commit message was already pointed out to me on
> #linux-sunxi. I was waiting for more comments before sending a v2.
> 
> But you do touch on something I also realized: there are actually
> three versions of the A64-OLinuXino. In fact only one of them has the
> WiFi board, which is already enabled in the current device tree.

Sigh, ok..

> Wouldn't it be better to split it into three separate device trees? I
> have made a patch that does that[1], if you think that is a good
> approach I can submit that as a patch and then later submit a patch on
> top of that to enable the eMMC only on the two boards that have it.

We can't really do that, unfortunately. If the device tree name was to
change for a given board, we'd break all the build systems, boot
scripts and distros out there.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180925/e6d44c9b/attachment.sig>
