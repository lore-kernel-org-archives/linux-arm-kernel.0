From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 01 Aug 2012 11:20:13 -0600
Subject: [PATCH v3 12/32] PCI/ARM: use PCIe capabilities access functions
 to simplify implementation
In-Reply-To: <1343836477-7287-13-git-send-email-jiang.liu@huawei.com>
References: <1343836477-7287-1-git-send-email-jiang.liu@huawei.com>
 <1343836477-7287-13-git-send-email-jiang.liu@huawei.com>
Message-ID: <5019654D.2000408@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/2012 09:54 AM, Jiang Liu wrote:
> From: Jiang Liu <jiang.liu@huawei.com>
> 
> Use PCIe capabilities access functions to simplify PCIe ARM implementation.
> 
> Signed-off-by: Jiang Liu <liuj97@gmail.com>

This is probably fine from my perspective assuming the underlying PCI
API implementation is OKd by relevant people.

Thierry, can you comment on whether this will conflict with your Tegra
PCIe driver series? If it doesn't, this patch can go through any
relevant PCI tree. If it does, we may have to take this through the
Tegra tree after merging the dependencies, or defer it to later.
