From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 7 Mar 2013 10:40:27 -0700
Subject: [PATCH 1/5] drivers: memory: Introduce Marvell EBU Device Bus
 driver
In-Reply-To: <1362660865-2755-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1362660865-2755-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1362660865-2755-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130307174027.GB20840@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 07, 2013 at 09:54:21AM -0300, Ezequiel Garcia wrote:

> +Example:
> +
> +	device-bus at d0010400 {
> +		status = "okay";
> +		ranges = <0 0 0xf0000000 0x1000000>; /* CS0 @addr 0xf0000000, size 0x1000000 */

The actual usage is fine, but the example is missing
#address-cells/#size-cells..

Jason
