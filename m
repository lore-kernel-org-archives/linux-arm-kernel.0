From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 04 Jan 2013 12:54:31 -0700
Subject: [PATCH] ARM: DT: tegra: add DT entry for KBC controller
In-Reply-To: <1357297442-28952-1-git-send-email-ldewangan@nvidia.com>
References: <1357297442-28952-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <50E73377.5070903@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/2013 04:04 AM, Laxman Dewangan wrote:
> NVIDIA's Tegra SoCs have the matrix keyboard controller which
> supports 16x8 type of matrix. The number of rows and columns
> are configurable.
> 
> Add DT entry for KBC controller.

These two look OK. Ping me once the related KBC driver changes are
checked in and I'll apply them.
