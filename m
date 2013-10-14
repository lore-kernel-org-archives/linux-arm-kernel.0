From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 14 Oct 2013 16:12:49 -0600
Subject: [PATCH v8 1/5] ARM: add basic support for Trusted Foundations
In-Reply-To: <1381527938-22840-2-git-send-email-acourbot@nvidia.com>
References: <1381527938-22840-1-git-send-email-acourbot@nvidia.com>
 <1381527938-22840-2-git-send-email-acourbot@nvidia.com>
Message-ID: <525C6C61.5090306@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/2013 03:45 PM, Alexandre Courbot wrote:
> Trusted Foundations is a TrustZone-based secure monitor for ARM that
> can be invoked using the same SMC-based API on all supported
> platforms. This patch adds initial basic support for Trusted
> Foundations using the ARM firmware API. Current features are limited
> to the ability to boot secondary processors.
> 
> Note: The API followed by Trusted Foundations does *not* follow the SMC
> calling conventions. It has nothing to do with PSCI neither and is only
> relevant to devices that use Trusted Foundations (like most Tegra-based
> retail devices).

Russell, are you OK with this patch? Is it OK if I take it through the
Tegra tree, or would you like to take it through your tree and give me a
stable branch I can apply the rest on top of?

Thanks.
