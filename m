From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 20 Jun 2013 16:36:34 +0530
Subject: [PATCH v2 1/4] ARM: davinci: da850: Use #include for all device
 trees
In-Reply-To: <1371203156-15260-2-git-send-email-avinashphilip@ti.com>
References: <1371203020-15092-1-git-send-email-avinashphilip@ti.com>
 <1371203156-15260-2-git-send-email-avinashphilip@ti.com>
Message-ID: <51C2E23A.5070409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/14/2013 3:15 PM, Philip Avinash wrote:
> Replace /include/ by #include for da850 device tree files, in order to
> use the C pre-processor, making use of #define features possible.
> 
> Signed-off-by: Philip Avinash <avinashphilip@ti.com>

Added this to my v3.11/dt branch.

Thanks,
Sekhar
