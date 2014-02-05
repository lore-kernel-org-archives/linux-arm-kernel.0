From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 05 Feb 2014 11:49:02 -0700
Subject: [PATCH v3 0/6] efuse driver for Tegra
In-Reply-To: <1390952176-30402-1-git-send-email-pdeschrijver@nvidia.com>
References: <1390952176-30402-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <52F2879E.3040700@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28/2014 04:36 PM, Peter De Schrijver wrote:
> This driver allows userspace to read the raw efuse data. Its userspace
> interface is modelled after the sunxi_sid driver which provides similar
> functionality for some Allwinner SoCs. It has been tested on
> Tegra20 (ventana), Tegra30 (beaverboard) and Tegra114 (dalmore).

I think this series should have been CC'd to Greg and Arnd, since
they're listed in MAINTAINERS for drivers/misc/. I'll need their ack to
apply these patches to the Tegra tree.
