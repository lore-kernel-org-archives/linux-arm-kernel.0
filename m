From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 15 Apr 2014 17:58:01 +0530
Subject: [PATCH 1/4] pinctrl: tegra: remove redundant data table fields
In-Reply-To: <1397511222-28533-1-git-send-email-swarren@wwwdotorg.org>
References: <1397511222-28533-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <534D25D1.8070202@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 April 2014 03:03 AM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
>          u32 drvtype_bit:5;

Seems this is also need for 6.
