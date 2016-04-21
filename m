From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 21 Apr 2016 13:53:50 +0100
Subject: [PATCH V2 15/15] coresight: configuring ETF in FIFO mode when
 acting as link
In-Reply-To: <1460483692-25061-16-git-send-email-mathieu.poirier@linaro.org>
References: <1460483692-25061-1-git-send-email-mathieu.poirier@linaro.org>
 <1460483692-25061-16-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <5718CD5E.2030200@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/16 18:54, Mathieu Poirier wrote:
> When part of a path but not identified as a sink, the EFT has to

nit: s/EFT/ETF

> be configured as a link and placed in HW FIFO mode.  As such when
> enabling a path, call the right configuration function based on
> the role the ETF if playing in this trace run.
>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
