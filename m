From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 09 Nov 2012 14:59:46 -0700
Subject: [PATCH] ARM: tegra: enable data prefetch on L2
In-Reply-To: <1352251597-2936-1-git-send-email-josephl@nvidia.com>
References: <1352251597-2936-1-git-send-email-josephl@nvidia.com>
Message-ID: <509D7CD2.8010309@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/2012 06:26 PM, Joseph Lo wrote:
> Enable the data prefetch on L2. The bit28 in aux ctrl register.

Applied to Tegra's for-3.8/soc branch. Thanks.
