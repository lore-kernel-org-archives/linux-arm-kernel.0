From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 19 Sep 2013 12:25:42 -0600
Subject: [PATCH V2 2/2] ARM: tegra: add palmas pincontrol to Dalmore device
 tree
In-Reply-To: <1379509642-19227-2-git-send-email-ldewangan@nvidia.com>
References: <1379509642-19227-1-git-send-email-ldewangan@nvidia.com>
 <1379509642-19227-2-git-send-email-ldewangan@nvidia.com>
Message-ID: <523B41A6.5040404@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2013 07:07 AM, Laxman Dewangan wrote:
> Add Palmas pincontrol to Dalmore device tree and make following
> configuration as default:
> - Disable DVFS1 and DVFS2.
> - Set GPIO6 to gpio mode.

> - Not sure that this will create the issue with other node having same
>   name as pinmux in top of the dts file.

This isn't an issue. Node names need to be unique within their parents,
not globally.
