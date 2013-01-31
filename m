From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 31 Jan 2013 21:25:23 +0530
Subject: [PATCH v3 02/15] ARM: mcpm: introduce the CPU/cluster power API
In-Reply-To: <1359445870-18925-3-git-send-email-nicolas.pitre@linaro.org>
References: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
 <1359445870-18925-3-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <510A93EB.7090506@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 January 2013 01:20 PM, Nicolas Pitre wrote:
> This is the basic API used to handle the powering up/down of individual
> CPUs in a (multi-)cluster system.  The platform specific backend
> implementation has the responsibility to also handle the cluster level
> power as well when the first/last CPU in a cluster is brought up/down.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
