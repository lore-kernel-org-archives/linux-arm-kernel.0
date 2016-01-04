From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 4 Jan 2016 11:04:08 +0100
Subject: [linux-sunxi] Re: [PATCH v3 2/3] ARM: dts: sun8i: Add Allwinner
 A83T dtsi
In-Reply-To: <567537FF.9010601@redhat.com>
References: <1450445451-311-1-git-send-email-vishnupatekar0510@gmail.com>
 <1450445451-311-3-git-send-email-vishnupatekar0510@gmail.com>
 <20151218214112.GU30359@lukather> <567537FF.9010601@redhat.com>
Message-ID: <20160104100408.GB11722@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Dec 19, 2015 at 11:57:03AM +0100, Hans de Goede wrote:
> >>+	memory {
> >>+		reg = <0x40000000 0x80000000>;
> >>+	};
> >
> >Is mainline u-boot usable ? If so, you can remove that node entirely.
> 
> mainline u-boot works for me when cold-booting from a sdcard, so I consider
> it usable :)

I'm glad we have the same definition of usable ;)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160104/f3b1f876/attachment.sig>
