From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 15 Mar 2013 07:44:36 +0100
Subject: [PATCH 2/3] mfd: Make AB8500_CORE select POWER_SUPPLY to fix
 build error
In-Reply-To: <1363298204-8014-2-git-send-email-arnd@arndb.de>
References: <1363298204-8014-1-git-send-email-arnd@arndb.de>
 <1363298204-8014-2-git-send-email-arnd@arndb.de>
Message-ID: <20130315064436.GD12559@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, Mar 14, 2013 at 10:56:39PM +0100, Arnd Bergmann wrote:
> From: Axel Lin <axel.lin@ingics.com>
> 
> This patch fixes below build error when CONFIG_POWER_SUPPLY is not set.
> 
> drivers/built-in.o: In function `ab8500_power_off':
> drivers/mfd/ab8500-sysctrl.c:37: undefined reference to `power_supply_get_by_name'
> drivers/mfd/ab8500-sysctrl.c:53: undefined reference to `power_supply_get_by_name'
> make: *** [vmlinux] Error 1
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Please apply to MFD tree for 3.9
Already applied to mfd-fixes.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
