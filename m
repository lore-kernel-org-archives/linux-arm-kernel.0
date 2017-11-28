From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 28 Nov 2017 17:04:51 +0100
Subject: [PATCH v3] staging: fsl-mc: move bus driver out of staging
In-Reply-To: <20171128152757.1058-1-laurentiu.tudor@nxp.com>
References: <20171128152757.1058-1-laurentiu.tudor@nxp.com>
Message-ID: <20171128160451.GC14512@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 28, 2017 at 05:27:57PM +0200, laurentiu.tudor at nxp.com wrote:
> diff --git a/drivers/staging/fsl-mc/bus/dpmcp.h b/drivers/bus/fsl-mc/dpmcp.h
> similarity index 100%
> rename from drivers/staging/fsl-mc/bus/dpmcp.h
> rename to drivers/bus/fsl-mc/dpmcp.h
> diff --git a/drivers/staging/fsl-mc/bus/dpmng-cmd.h b/drivers/bus/fsl-mc/dpmng-cmd.h
> similarity index 100%
> rename from drivers/staging/fsl-mc/bus/dpmng-cmd.h
> rename to drivers/bus/fsl-mc/dpmng-cmd.h
> diff --git a/drivers/staging/fsl-mc/bus/dprc-cmd.h b/drivers/bus/fsl-mc/dprc-cmd.h
> similarity index 100%
> rename from drivers/staging/fsl-mc/bus/dprc-cmd.h
> rename to drivers/bus/fsl-mc/dprc-cmd.h
> diff --git a/drivers/staging/fsl-mc/bus/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
> similarity index 99%
> rename from drivers/staging/fsl-mc/bus/dprc-driver.c
> rename to drivers/bus/fsl-mc/dprc-driver.c

Hi Laurentiu

It is hard to review code when we don't see it. 

   Andrew
