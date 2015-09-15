From: scottwood@freescale.com (Scott Wood)
Date: Tue, 15 Sep 2015 18:56:38 -0500
Subject: [PATCH v2 1/2] fsl: Add binding for RCPM
In-Reply-To: <1442307339-15225-1-git-send-email-dongsheng.wang@freescale.com>
References: <1442307339-15225-1-git-send-email-dongsheng.wang@freescale.com>
Message-ID: <1442361398.2909.164.camel@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-09-15 at 16:55 +0800, Dongsheng Wang wrote:
> +* Freescale RCPM Wakeup Source Device Tree Bindings
> +-------------------------------------------
> +Required rcpm-wakeup property should be added to a device node if the 
> device
> +can be used as a wakeup source.
> +
> +  - rcpm-wakeup: The value of the property consists of 3 cells. The first 
> cell
> +     is a pointer to the rcpm node, the second cell is the bit mask that
> +     should be set in IPPDEXPCR0, and the last cell is for IPPDEXPCR1.
> +     Note: If the platform has no IPPDEXPCR1 register, put a zero here.

What if a future platform has more than two of these registers?

-Scott
