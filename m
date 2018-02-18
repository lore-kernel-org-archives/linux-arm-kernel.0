From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 18 Feb 2018 16:00:43 +0100
Subject: [PATCH] soc: actions: Convert to SPDX license identifiers
In-Reply-To: <20180121170143.29915-1-afaerber@suse.de>
References: <20180121170143.29915-1-afaerber@suse.de>
Message-ID: <72b34d7f-8987-0bc3-4336-c833ffb69bb3@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 21.01.2018 um 18:01 schrieb Andreas F?rber:
> Replace textual license notices with SPDX-License-Identifier lines.
> Add an SPDX-License-Identifier for the Makefile.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  drivers/soc/actions/Makefile         | 2 ++
>  drivers/soc/actions/owl-sps-helper.c | 6 +-----
>  drivers/soc/actions/owl-sps.c        | 6 +-----
>  3 files changed, 4 insertions(+), 10 deletions(-)

Applied to v4.17/drivers:
https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git/log/?h=v4.17/drivers

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
