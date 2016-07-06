From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 6 Jul 2016 14:06:04 +0800
Subject: [PATCH] phy: sun9i-usb: fix error handling
In-Reply-To: <1467784806-17091-1-git-send-email-christophe.jaillet@wanadoo.fr>
References: <1467784806-17091-1-git-send-email-christophe.jaillet@wanadoo.fr>
Message-ID: <CAGb2v64D-AcrG8Xot79_7PnUKFnHonU65Crfw7QONj_TFLwv5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 6, 2016 at 2:00 PM, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
> This is likely that checking 'phy->hsic_clk' instead of 'phy->clk' is
> expected here.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Chen-Yu Tsai <wens@csie.org>
