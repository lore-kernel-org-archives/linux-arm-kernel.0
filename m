From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 24 Jul 2015 17:19:13 +0530
Subject: [RESEND][PATCH 2/4] spi: davinci: Choose correct pre-scaler limit
 based on SOC
In-Reply-To: <1437568344-18889-3-git-send-email-fcooper@ti.com>
References: <1437568344-18889-1-git-send-email-fcooper@ti.com>
 <1437568344-18889-3-git-send-email-fcooper@ti.com>
Message-ID: <55B22639.9010204@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 July 2015 06:02 PM, Franklin S Cooper Jr wrote:
> Currently the pre-scaler limit is incorrect. The value differs slightly
> for various devices so a single value can't be used. Using the compatible
> field select the correct pre-scaler limit.
> 
> Add new compatible field value for Keystone devices to support their
> unique pre-scaler limit value.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>

Reviewed-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
