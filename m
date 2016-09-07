From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 7 Sep 2016 22:37:14 +0200
Subject: [PATCH v2 7/7] ARM: sun8i: Convert the A23 and A33 to the CCU
In-Reply-To: <CAGb2v64r-vURPZNhPhKv2+7kByckdxW=fPH-9qAfBLxH992qWQ@mail.gmail.com>
References: <20160906121837.7517-1-maxime.ripard@free-electrons.com>
 <20160906121837.7517-8-maxime.ripard@free-electrons.com>
 <CAGb2v64r-vURPZNhPhKv2+7kByckdxW=fPH-9qAfBLxH992qWQ@mail.gmail.com>
Message-ID: <20160907203714.GG28134@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Sep 06, 2016 at 10:08:05PM +0800, Chen-Yu Tsai wrote:
> On Tue, Sep 6, 2016 at 8:18 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Now that we have support for the CCU driver in sunxi-ng, convert the A23
> > and A33 DTs to that driver.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> 
> TODO note for later:
> 
>     The usb_otg and usbphy node definitions can be moved to the common dtsi
>     file, and there compatibles and regs (for usbphy) defined in the SoC
>     dtsi.

Yes, I noticed that too :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160907/3d3c939d/attachment.sig>
