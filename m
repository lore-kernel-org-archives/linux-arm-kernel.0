From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 7 Apr 2014 18:31:50 +0100
Subject: [PATCH] ARM64: Remove duplicated Kconfig entry for
 "kernel/power/Kconfig"
In-Reply-To: <1396523809-6945-1-git-send-email-hanjun.guo@linaro.org>
References: <1396523809-6945-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20140407173149.GF8479@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 03, 2014 at 12:16:49PM +0100, Hanjun Guo wrote:
> There is a duplicated Kconfig entry for "kernel/power/Kconfig"
> in menu "Power management options" and "CPU Power Management",
> remove the one from menu "CPU Power Management" suggested by
> Viresh.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks. I'll push this after -rc1 (to use a more stable base for my
tree).

-- 
Catalin
