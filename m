From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 22 Jan 2013 04:27:45 +0100
Subject: [PATCH 3/4] watchdog: add support for ux500_wdt watchdog
In-Reply-To: <1358509214-22407-4-git-send-email-fabio.baltieri@linaro.org>
References: <1358509214-22407-1-git-send-email-fabio.baltieri@linaro.org>
 <1358509214-22407-4-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <20130122032745.GP7409@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio, Wim,

On Fri, Jan 18, 2013 at 12:40:13PM +0100, Fabio Baltieri wrote:
> This patch adds support for the ux500_wdt watchdog that is found in
> ST-Ericsson Ux500 platform.  The driver is based on PRCMU APIs.
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> ---
>  drivers/watchdog/Kconfig                |  12 +++
>  drivers/watchdog/Makefile               |   1 +
>  drivers/watchdog/ux500_wdt.c            | 171 ++++++++++++++++++++++++++++++++
>  include/linux/platform_data/ux500_wdt.h |  19 ++++
>  4 files changed, 203 insertions(+)
>  create mode 100644 drivers/watchdog/ux500_wdt.c
>  create mode 100644 include/linux/platform_data/ux500_wdt.h
There is a dependency between this one an the first patch.
Wim, would you like me to carry this patch through the MFD tree ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
