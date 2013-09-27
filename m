From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 27 Sep 2013 11:50:46 +0100
Subject: [RFT PATCH v1 0/7] enable FPSIMD lazy save and restore for arm64
In-Reply-To: <1380269087-8520-1-git-send-email-liuj97@gmail.com>
References: <1380269087-8520-1-git-send-email-liuj97@gmail.com>
Message-ID: <20130927105045.GA11063@MacBook-Pro.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 09:04:40AM +0100, Jiang Liu wrote:
> From: Jiang Liu <jiang.liu@huawei.com>
> 
> This patchset enables FPSIMD lazy save and restore for ARM64, you could
> apply it against v3.12-rc2.
> 
> We have done basic functional tests on ARM fast model, but still lack
> of detail performance benchmark on real hardware platforms. We would
> appreciate if you could help to test it on really hardware platforms!

That's my issue as well, I would like to see some benchmarks before
merging such patches.

-- 
Catalin
