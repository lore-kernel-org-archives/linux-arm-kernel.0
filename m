From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 15 Apr 2014 18:01:49 +0530
Subject: [PATCH 3/4] pinctrl: tegra: reduce size of data table fields
In-Reply-To: <1397511222-28533-3-git-send-email-swarren@wwwdotorg.org>
References: <1397511222-28533-1-git-send-email-swarren@wwwdotorg.org>
 <1397511222-28533-3-git-send-email-swarren@wwwdotorg.org>
Message-ID: <534D26B5.7010009@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 April 2014 03:03 AM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
> The range of npins and function ID values is small enough to fit into a
> u8. Use this type rather than unsigned to shrink the pinmux data tables.
>
For 3 and 4, also
Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
