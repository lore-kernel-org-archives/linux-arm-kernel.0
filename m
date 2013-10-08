From: will.deacon@arm.com (Will Deacon)
Date: Tue, 8 Oct 2013 11:48:01 +0100
Subject: [PATCH 1/1] iommu: arm-smmu: Use devm_ioremap_resource
In-Reply-To: <1381228955-24313-1-git-send-email-sachin.kamat@linaro.org>
References: <1381228955-24313-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <20131008104801.GK17148@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 11:42:35AM +0100, Sachin Kamat wrote:
> devm_request_and_ioremap is deprecated. Use devm_ioremap_resource
> instead.

I already have an identical patch from Julia, queued for 3.13.

Thanks,

Will
