From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 13 Nov 2018 08:36:16 +0100
Subject: [PATCH v2 2/2] stagin: vchi: Add SPDX-License-Identifier
In-Reply-To: <20181113003733.9615-3-andrealmeid@riseup.net>
References: <20181113003733.9615-1-andrealmeid@riseup.net>
 <20181113003733.9615-3-andrealmeid@riseup.net>
Message-ID: <1b4817a6-d084-9347-1c0c-faac749156f4@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

Am 13.11.2018 um 01:37 schrieb andrealmeid at riseup.net:
> From: Andr? Almeida <andrealmeid@riseup.net>
>
> As pointed by Stefan Wahren in v1, this file is dual licensed
> as GPL-2 and BSD-3.

please avoid references to old versions in the commit log, because after
applying this patch the context get lost.

Looks like you missed my comment about removal of the license text.
Please look at this example:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20181113&id=bb1e67793f3ee42449f60c2288096da01199443e

Best regards

>
> Using multiple license representation as shown here [1].
>
> [1] https://spdx.org/sites/cpstandard/files/pages/files/using_spdx_license_list_short_identifiers.pdf
>
> Signed-off-by: Andr? Almeida <andrealmeid@riseup.net>
>
> ---
>
>  drivers/staging/vc04_services/interface/vchi/vchi_mh.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/staging/vc04_services/interface/vchi/vchi_mh.h b/drivers/staging/vc04_services/interface/vchi/vchi_mh.h
> index 40c760d493a1..5c780ec49ff7 100644
> --- a/drivers/staging/vc04_services/interface/vchi/vchi_mh.h
> +++ b/drivers/staging/vc04_services/interface/vchi/vchi_mh.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0) */
>  /**
>   * Copyright (c) 2010-2012 Broadcom. All rights reserved.
>   *
