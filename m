From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 15 Nov 2012 17:04:03 +0000
Subject: [PATCH] pinctrl: nomadik: Staticize non-exported symbols
In-Reply-To: <1352995295.10636.1.camel@phoenix>
References: <1352995295.10636.1.camel@phoenix>
Message-ID: <20121115170403.GD14476@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Nov 2012, Axel Lin wrote:

> They are not referenced outside of this file, make them static.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/pinctrl/pinctrl-nomadik.c |   26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)

Seems sensible:

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
