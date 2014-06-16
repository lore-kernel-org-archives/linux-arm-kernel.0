From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Jun 2014 12:42:44 -0600
Subject: [PATCH v8 0/6] efuse driver for Tegra
In-Reply-To: <1402587400-1544-1-git-send-email-pdeschrijver@nvidia.com>
References: <1402587400-1544-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <539F3AA4.6040001@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2014 09:36 AM, Peter De Schrijver wrote:
> This driver allows userspace to read the raw efuse data. Its userspace
> interface is modelled after the sunxi_sid driver which provides similar
> functionality for some Allwinner SoCs. It has been tested on
> Tegra20 (ventana), Tegra30 (beaverboard), Tegra114 (dalmore) and
> Tegra124 (jetson TK1).

I've applied this series to Tegra's for-3.17/fuse-move branch.
