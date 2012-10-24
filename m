From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 24 Oct 2012 15:22:14 +0400
Subject: [PATCH v2] ARM: dm365: replace V4L2_OUT_CAP_CUSTOM_TIMINGS with
 V4L2_OUT_CAP_DV_TIMINGS
In-Reply-To: <5087CEDC.9050103@ti.com>
References: <1350998273-19769-1-git-send-email-prabhakar.lad@ti.com>
 <5087CEDC.9050103@ti.com>
Message-ID: <5087CF66.6020805@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24.10.2012 15:19, Sekhar Nori wrote:

>> This patch replaces V4L2_OUT_CAP_CUSTOM_TIMINGS macro with
>> V4L2_OUT_CAP_DV_TIMINGS. As V4L2_OUT_CAP_CUSTOM_TIMINGS is being phased
>> out.

>> Signed-off-by: Lad, Prabhakar <prabhakar.lad@ti.com>
>> Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
>> Cc: Sekhar Nori <nsekhar@ti.com>
>> Cc: Sergei Shtylyov <sshtylyov@mvista.com>

> Patches for mach-davinci should have a 'davinci:' prefix after 'ARM:'.
> Can you please resend with that fixed?

    Also, the patch is for DM365 EVM board, not DM365 SoC.

> Thanks,
> Sekhar

WBR, Sergei
