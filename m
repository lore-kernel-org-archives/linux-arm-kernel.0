From: acourbot@nvidia.com (Alex Courbot)
Date: Tue, 19 Feb 2013 12:42:57 +0900
Subject: [RFC PATCH 8/9] ARM: dt: t30 cardhu: add dt entry for thermal
 driver
In-Reply-To: <1361187031-3679-9-git-send-email-wni@nvidia.com>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com>
 <1361187031-3679-9-git-send-email-wni@nvidia.com>
Message-ID: <5122F4C1.9050108@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/18/2013 08:30 PM, Wei Ni wrote:
> diff --git a/Documentation/devicetree/bindings/thermal/tegra3-thermal.txt b/Documentation/devicetree/bindings/thermal/tegra3-thermal.txt
> new file mode 100644

This should go with the previous patch (which introduces the driver) 
instead of this one. Bindings should be documented with their driver.

Alex.
