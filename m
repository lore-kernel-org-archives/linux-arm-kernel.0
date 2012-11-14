From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 14 Nov 2012 13:54:33 -0700
Subject: [PATCH] ARM: tegra: Implement 6395/1 for Tegra
In-Reply-To: <1352903243-5389-1-git-send-email-pdeschrijver@nvidia.com>
References: <1352903243-5389-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <50A40509.5080006@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/14/2012 07:27 AM, Peter De Schrijver wrote:
> This patch implements ARM linux patch 6395/1 for Tegra. See commit
> 1a8e41cd672f894bbd74874eac601e6cedf838fb for details.

I've applied this patch to Tegra's for-3.8/soc branch with the following
enhanced commit description:

>     ARM: tegra: Implement 6395/1 for Tegra
>     
>     This patch implements ARM linux patch 6395/1 for Tegra. See commit
>     1a8e41c "ARM: 6395/1: VExpress: Set bit 22 in the PL310 (cache
>     controller) AuxCtlr register" for details.
>     
>     Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
>     [swarren: added commit subject for referenced patch]
>     Signed-off-by: Stephen Warren <swarren@nvidia.com>
