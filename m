From: punit.agrawal@arm.com (Punit Agrawal)
Date: Fri, 22 Jun 2018 13:30:57 +0100
Subject: [PATCH 3/4] drivers/bus: arm-cci: Use SPDX license information
In-Reply-To: <20180622110628.GA23452@sesnaco> (Mawanda Henry's message of
 "Fri, 22 Jun 2018 14:06:29 +0300")
References: <20180622110628.GA23452@sesnaco>
Message-ID: <87r2kzypdq.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ + alkml, will ]

Please make sure to cc linux-arm-kernel and the appropriate maintainers
(see scripts/get_maintainer.pl) for Arm related patches.

Mawanda Henry <mawandahenrynaco@gmail.com> writes:

> SPDX licence header helps developers and machines to know the right
> license governing a particular file

It's good practice to update the commit log if you change the
commit. Something like -

"While we are at it, also update the MODULE_LICENSE() to reflect the
license version - GPL v2"

> Signed-off-by: Mawanda Henry <mawandahenrynaco@gmail.com>

With that change,

Acked-by: Punit Agrawal <punit.agrawal@arm.com>

> ---
>  drivers/bus/arm-cci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> index ab04201..4f92f39 100644
> --- a/drivers/bus/arm-cci.c
> +++ b/drivers/bus/arm-cci.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * CCI cache coherent interconnect driver
>   *
> @@ -575,5 +575,5 @@ EXPORT_SYMBOL_GPL(cci_probed);
>  
>  early_initcall(cci_init);
>  core_initcall(cci_platform_init);
> -MODULE_LICENSE("GPL");
> +MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("ARM CCI support");
