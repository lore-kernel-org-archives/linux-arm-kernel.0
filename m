From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 6 Sep 2016 22:08:05 +0800
Subject: [PATCH v2 7/7] ARM: sun8i: Convert the A23 and A33 to the CCU
In-Reply-To: <20160906121837.7517-8-maxime.ripard@free-electrons.com>
References: <20160906121837.7517-1-maxime.ripard@free-electrons.com>
 <20160906121837.7517-8-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64r-vURPZNhPhKv2+7kByckdxW=fPH-9qAfBLxH992qWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 6, 2016 at 8:18 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Now that we have support for the CCU driver in sunxi-ng, convert the A23
> and A33 DTs to that driver.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

TODO note for later:

    The usb_otg and usbphy node definitions can be moved to the common dtsi
    file, and there compatibles and regs (for usbphy) defined in the SoC
    dtsi.
