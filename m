From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Mar 2013 19:36:35 +0000
Subject: [PATCH 11/11] devtree: add binding documentation for sp804
In-Reply-To: <1363820051-24428-12-git-send-email-robherring2@gmail.com>
References: <1363820051-24428-1-git-send-email-robherring2@gmail.com>
 <1363820051-24428-12-git-send-email-robherring2@gmail.com>
Message-ID: <20130321193635.GT4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 20, 2013 at 05:54:11PM -0500, Rob Herring wrote:
> +Optional properties:
> +- arm,sp804-has-irq = <#>: In the case of only 1 timer irq line connected, this
> +	specifies if the irq connection is for timer 1 or timer 2. A value of 1
> +	or 2 should be used.

This fails to mention that it has any bearing on the clocks.
