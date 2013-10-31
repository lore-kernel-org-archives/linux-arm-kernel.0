From: will.deacon@arm.com (Will Deacon)
Date: Thu, 31 Oct 2013 15:59:34 +0000
Subject: [PATCH 3/5] iommu/arm-smmu: Use devm_ioremap_resource
In-Reply-To: <1383217687-12037-4-git-send-email-tushar.behera@linaro.org>
References: <1383217687-12037-1-git-send-email-tushar.behera@linaro.org>
 <1383217687-12037-4-git-send-email-tushar.behera@linaro.org>
Message-ID: <20131031155933.GA30623@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 11:08:05AM +0000, Tushar Behera wrote:
> While at it, propagate the error code.

Thanks, but I already have an equivalent patch queued which Joerg is going
to pull real soon now (right, Joerg? :p).

Will
