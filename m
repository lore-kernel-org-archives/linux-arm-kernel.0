From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 25 Apr 2016 13:57:58 +0200
Subject: [GIT PULL] move ARM LCD display driver to auxdisplay
In-Reply-To: <CACRpkdbyO0axd5ergYZcXO302f2fFAPKrSNevkvreP1kRjm-vw@mail.gmail.com>
References: <CACRpkdbyO0axd5ergYZcXO302f2fFAPKrSNevkvreP1kRjm-vw@mail.gmail.com>
Message-ID: <20160425115758.GA4874@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Apr 23, 2016 at 11:43:58AM +0200, Linus Walleij wrote:
> Hi ARM SoC guys,
> 
> these two patches move the ARM character LCD driver from
> misc drivers to the auxdisplay subsystem where it belongs and
> updates the defconfig for the RealView accordingly.
> 
> Please pull it into some cleanup branch in the ARM SoC
> tree.
> 
> I tried to get some ACK from the auxdisplay maintainer but no
> reaction.

Auxdisplay is not a new framework, but rather a very old one.

It got introduced in 2.6.21, and only received a couple of drivers
since.

It seems to be quite redundant with fbdev deferred_io, which itself is
almost deprecated these days.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160425/23188532/attachment.sig>
