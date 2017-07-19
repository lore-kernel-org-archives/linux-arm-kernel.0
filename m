From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 19 Jul 2017 12:37:39 +0200
Subject: [PATCH] soc: Convert to using %pOF instead of full_name
In-Reply-To: <20170718214339.7774-49-robh@kernel.org>
References: <20170718214339.7774-49-robh@kernel.org>
Message-ID: <6e936e3c-0e46-4f06-5571-5942d6fb1778@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/18/2017 11:43 PM, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Scott Wood <oss@buserror.net>
> Cc: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: linuxppc-dev at lists.ozlabs.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-mediatek at lists.infradead.org
> Cc: linux-renesas-soc at vger.kernel.org
> Cc: linux-samsung-soc at vger.kernel.org
> ---
>   drivers/soc/fsl/qbman/bman_ccsr.c    | 10 +++++-----
>   drivers/soc/fsl/qbman/bman_portal.c  |  8 +++-----
>   drivers/soc/fsl/qbman/qman_ccsr.c    | 12 ++++++------
>   drivers/soc/fsl/qbman/qman_portal.c  | 11 ++++-------
>   drivers/soc/fsl/qe/gpio.c            |  4 ++--
>   drivers/soc/mediatek/mtk-pmic-wrap.c |  4 ++--

For Mediatek:

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
