From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 12 Jul 2011 17:13:39 +0300
Subject: [PATCH 1/3] Framework for exporting System-on-Chip information
	via sysfs
In-Reply-To: <1310476090-9807-1-git-send-email-lee.jones@linaro.org>
References: <1310476090-9807-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20110712141339.GB24957@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Tue, Jul 12, 2011 at 02:08:08PM +0100, Lee Jones wrote:
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/base/Kconfig    |   10 +++++
>  drivers/base/Makefile   |    1 +
>  drivers/base/soc.c      |   98 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/sys_soc.h |   45 +++++++++++++++++++++
>  4 files changed, 154 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/base/soc.c
>  create mode 100644 include/linux/sys_soc.h

I guess you should Cc Greg Kroah-Hartman <gregkh@suse.de> on this series.

baruch

[snip]

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
