From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 17 Dec 2013 15:58:59 -0700
Subject: [PATCH 1/4] ARM: tegra: moving tegra_bct_strapping to tegra-soc.h
 for global visibility
In-Reply-To: <1387272400-4689-2-git-send-email-josephl@nvidia.com>
References: <1387272400-4689-1-git-send-email-josephl@nvidia.com>
 <1387272400-4689-2-git-send-email-josephl@nvidia.com>
Message-ID: <52B0D733.3030109@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/17/2013 02:26 AM, Joseph Lo wrote:
> This patch moves the tegra_btc_strapping variable to the tegra-soc.h for

s/btc/bct/
