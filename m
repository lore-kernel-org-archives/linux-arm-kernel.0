From: guohanjun@huawei.com (Hanjun Guo)
Date: Wed, 10 Aug 2016 09:56:49 +0800
Subject: [PATCH v5 00/14] fix some type infos and bugs for arm64/of numa
In-Reply-To: <1470647899-6324-1-git-send-email-thunder.leizhen@huawei.com>
References: <1470647899-6324-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <57AA89E1.6050103@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhen,

On 2016/8/8 17:18, Zhen Lei wrote:
> v4 -> v5:
> This version has no code changes, just add "Acked-by: Rob Herring <robh@kernel.org>"
> into patches 1, 2, 4, 6, 7, 13, 14. Because these patches rely on some acpi numa
> patches, and the latter had not been upstreamed in 4.7, but upstreamed in 4.8-rc1,
> so I resend my patches again.

I think we need to mention this patch set is rebased on top of 4,8-rc1, and

 - patch 1~5 are fixes which are targeting for 4.8.

 - patch 6~14 are cleanups and new features, which are targeting for 4.9, in detail,
   - patch 6~8 are cleanups
   - patch 9~14 are new features adding per cpu area and memory less node support.

Catalin, do you think Zhen needs to separate this patch set into two and then resend?

Thanks
Hanjun
