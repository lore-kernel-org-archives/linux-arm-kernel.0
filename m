From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 18 Dec 2014 08:43:14 +0000
Subject: [STLinux Kernel] [PATCH 6/8] watchdog: st_wdt: Add new driver
 for ST's LPC Watchdog
In-Reply-To: <1418834727-1602-7-git-send-email-lee.jones@linaro.org>
References: <1418834727-1602-1-git-send-email-lee.jones@linaro.org>
 <1418834727-1602-7-git-send-email-lee.jones@linaro.org>
Message-ID: <20141218084314.GA25901@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Wed, 17 Dec 2014, Lee Jones wrote:

> Signed-off-by: David Paris <david.paris@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/watchdog/Kconfig  |  13 ++
>  drivers/watchdog/Makefile |   1 +
>  drivers/watchdog/st_wdt.c | 323 ++++++++++++++++++++++++++++++++++++++++++++++

You don't have a patch which adds the new files created in this series into
the STI section of the MAINTAINERS file?

regards,

Peter.
