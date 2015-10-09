From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 9 Oct 2015 22:20:29 +0800
Subject: [PATCH v3 1/5] ARM: sunxi: Add R8 support
In-Reply-To: <1444380177-15302-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1444380177-15302-1-git-send-email-maxime.ripard@free-electrons.com>
 <1444380177-15302-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65b-viLFXdFrx_A864Ekc90CJtWr0JYKAAs=yrZ+K8CUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 9, 2015 at 4:42 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The R8 is a new Allwinner SoC based on the A13. While both are very
> similar, there's still a few differences. Introduce a new compatible to
> deal with them.
>
> In order to have a consistent naming, instead of mentionning the allwinner
                                                   ^               ^
nit:                                               mentioning      Allwinner

Fix when you apply?

> A series as the machine name, switch to sun4i/sun5i like what is done for
> the other families.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Thanks
