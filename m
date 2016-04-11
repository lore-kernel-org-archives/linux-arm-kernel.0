From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 11 Apr 2016 13:49:55 +0530
Subject: [PATCH v3 01/16] dt: davinci: use proper address after @
In-Reply-To: <1458863503-31121-2-git-send-email-david@lechnology.com>
References: <1458863503-31121-1-git-send-email-david@lechnology.com>
 <1458863503-31121-2-git-send-email-david@lechnology.com>
Message-ID: <570B5E2B.4080502@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 25 March 2016 05:21 AM, David Lechner wrote:
> TI has been using the physical address in DT after the @ in device nodes.
> The device tree convention is to use the same address that is used for
> the reg property. This updates all davinci DT files to use the proper
> convention.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> 
> v3 changes: This is a new patch.

Applied through a copy of this patch posted by Petr in thread "ARM: DTS:
da850: add node for i2c1"

Thanks,
Sekhar
