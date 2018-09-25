From: robh@kernel.org (Rob Herring)
Date: Tue, 25 Sep 2018 14:10:47 -0500
Subject: [PATCH v2 01/03] dt-bindings: clock: Add Clock Management Unit
 for Actions Semi S500 SoC
In-Reply-To: <CADHB5bBkyE90LVrWjt0ziU+oe=4sc8G_513VGECc++6xQ2ACdA@mail.gmail.com>
References: <CADHB5bBkyE90LVrWjt0ziU+oe=4sc8G_513VGECc++6xQ2ACdA@mail.gmail.com>
Message-ID: <20180925191047.GA14410@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2018 at 12:36:36PM -0300, Edgar Bernardi Righi wrote:
> Add Clock Management Unit for Actions Semi S500 SoC. Dt-Bindings
> constants added.
> Tested on a Lemaker Guitar board.
> 
> Signed-off-by: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
> 
> diff --git a/include/dt-bindings/clock/actions,s500-cmu.h
> b/include/dt-bindings/clock/actions,s500-cmu.h
> new file mode 100644
> index 000000000000..34e5849ffcf1
> --- /dev/null
> +++ b/include/dt-bindings/clock/actions,s500-cmu.h
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0+

Headers should be /* */ style comments.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> +//
> +// Device Tree binding constants for Actions Semi S500 Clock Management Unit
> +//
> +// Copyright (c) 2014 Actions Semi Inc.
> +// Copyright (c) 2018 Linaro Ltd.
> +// Copyright (c) 2018 LSI-TEC - Caninos Loucos
