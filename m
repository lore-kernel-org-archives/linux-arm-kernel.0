From: joe@perches.com (Joe Perches)
Date: Wed, 16 Apr 2014 20:18:05 -0700
Subject: [PATCH v3 1/4] MAINTAINERS: Add entry for APM X-Gene SoC
 ethernet driver
In-Reply-To: <1397702368-4846-2-git-send-email-isubramanian@apm.com>
References: <1397702368-4846-1-git-send-email-isubramanian@apm.com>
 <1397702368-4846-2-git-send-email-isubramanian@apm.com>
Message-ID: <1397704685.14062.14.camel@joe-AO725>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-04-16 at 19:39 -0700, Iyappan Subramanian wrote:
> This patch adds a MAINTAINERS entry for APM X-Gene SoC
> ethernet driver.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -686,6 +686,14 @@ S:	Maintained
>  F:	drivers/net/appletalk/
>  F:	net/appletalk/
>  
> +APPLIED MICRO (APM) X-GENE SOC ETHERNET DRIVER
> +M:	Iyappan Subramanian <isubramanian@apm.com>
> +M:	Keyur Chudgar <kchudgar@apm.com>
> +M:	Ravi Patel <rapatel@apm.com>
> +S:	Maintained
> +F:	drivers/net/ethernet/apm/xgene

Please add a terminating slash to show this is a directory.

F:	drivers/net/ethernet/apm/xgene/
