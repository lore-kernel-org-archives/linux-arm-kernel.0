From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 24 Oct 2012 16:49:56 +0530
Subject: [PATCH v2] ARM: dm365: replace V4L2_OUT_CAP_CUSTOM_TIMINGS with
 V4L2_OUT_CAP_DV_TIMINGS
In-Reply-To: <1350998273-19769-1-git-send-email-prabhakar.lad@ti.com>
References: <1350998273-19769-1-git-send-email-prabhakar.lad@ti.com>
Message-ID: <5087CEDC.9050103@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/23/2012 6:47 PM, Prabhakar Lad wrote:
> From: Lad, Prabhakar <prabhakar.lad@ti.com>
> 
> This patch replaces V4L2_OUT_CAP_CUSTOM_TIMINGS macro with
> V4L2_OUT_CAP_DV_TIMINGS. As V4L2_OUT_CAP_CUSTOM_TIMINGS is being phased
> out.
> 
> Signed-off-by: Lad, Prabhakar <prabhakar.lad@ti.com>
> Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Sergei Shtylyov <sshtylyov@mvista.com>

Patches for mach-davinci should have a 'davinci:' prefix after 'ARM:'.
Can you please resend with that fixed?

Thanks,
Sekhar
