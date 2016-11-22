From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 22 Nov 2016 09:15:13 -0700
Subject: [RFC PATCH 04/11] PCI: tegra: limit to MMU build only
In-Reply-To: <1479806768-39911-5-git-send-email-vladimir.murzin@arm.com>
References: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
 <1479806768-39911-5-git-send-email-vladimir.murzin@arm.com>
Message-ID: <65053923-c783-d8d9-d594-aa18cbed413e@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/22/2016 02:26 AM, Vladimir Murzin wrote:
> This driver uses functionality which available for MMU build only,
> thus add dependency on MMU.

I'd expect ARCH_TEGRA to depend on MMU instead.
