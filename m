From: davidb@codeaurora.org (David Brown)
Date: Tue, 26 Apr 2011 09:26:26 -0700
Subject: [PM8921 MFD V5 5/6] MAINTAINERS: Add patterns for pmic 8921 files
	to MSM subsystem
In-Reply-To: <1302039657-19395-6-git-send-email-adharmap@codeaurora.org>
	(Abhijeet Dharmapurikar's message of "Tue, 5 Apr 2011 14:40:56 -0700")
References: <1302039657-19395-1-git-send-email-adharmap@codeaurora.org>
	<1302039657-19395-6-git-send-email-adharmap@codeaurora.org>
Message-ID: <8yay62x6kst.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 05 2011, Abhijeet Dharmapurikar wrote:

> Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
> ---
>  MAINTAINERS |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6b4b9cd..b9db68b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -916,6 +916,8 @@ F:	drivers/mmc/host/msm_sdcc.h
>  F:	drivers/tty/serial/msm_serial.h
>  F:	drivers/tty/serial/msm_serial.c
>  F:	drivers/platform/msm/
> +F:	drivers/*/pm8???-*
> +F:	include/linux/mfd/pm8xxx/
>  T:	git git://codeaurora.org/quic/kernel/davidb/linux-msm.git
>  S:	Maintained

Acked-by: David Brown <davidb@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
