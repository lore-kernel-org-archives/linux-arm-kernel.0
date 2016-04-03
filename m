From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sun, 3 Apr 2016 15:05:27 +0900
Subject: [PATCH 1/2] phy: Group vendor specific phy drivers
In-Reply-To: <1459510156-9147-1-git-send-email-gautam.vivek@samsung.com>
References: <1459510156-9147-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <20160403060527.GA5034@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2016 at 04:59:15PM +0530, Vivek Gautam wrote:
> Adding vendor specific directories in phy to group
> phy drivers under their respective vendor umbrella.
> 
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> ---
> 
> With growing number of phy drivers, it makes sense to
> group these drivers under their respective vendor/platform
> umbrella directory.
> 
> Build-tested 'multi_v7_defconfig'.

Please update also the MAINTAINERS file. For many entires the path won't
match anymore.

Best regards,
Krzysztof
