From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 3 Oct 2012 14:36:03 +0530
Subject: [PATCH] davinci: vpbe: replace V4L2_OUT_CAP_CUSTOM_TIMINGS with
 V4L2_OUT_CAP_DV_TIMINGS
In-Reply-To: <1349245973-7377-1-git-send-email-prabhakar.lad@ti.com>
References: <1349245973-7377-1-git-send-email-prabhakar.lad@ti.com>
Message-ID: <506BFFFB.5050103@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/3/2012 12:02 PM, Prabhakar wrote:
> From: Lad, Prabhakar <prabhakar.lad@ti.com>
> 
> This patch replaces V4L2_OUT_CAP_CUSTOM_TIMINGS macro with
> V4L2_OUT_CAP_DV_TIMINGS. As V4L2_OUT_CAP_CUSTOM_TIMINGS is being phased
> out.
> 
> Signed-off-by: Lad, Prabhakar <prabhakar.lad@ti.com>
> Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Hans Verkuil <hansverk@cisco.com>
> Cc: Mauro Carvalho Chehab <mchehab@redhat.com>

For the DaVinci platform change:

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
