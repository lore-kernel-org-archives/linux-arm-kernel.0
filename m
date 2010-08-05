From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 05 Aug 2010 16:37:20 -0700
Subject: [PATCH V2] HRT support in Samsung S5P Platform
In-Reply-To: <9852485.1007371280726519429.JavaMail.weblogic@epml04>
References: <9852485.1007371280726519429.JavaMail.weblogic@epml04>
Message-ID: <1281051440.30969.21.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-08-02 at 05:21 +0000, MADHAV SINGHCHAUHAN wrote:
> +config SAMSUNG_HRT_RTC_SYSTIMER
> +       bool "HRtimer and Dynamic Tick support"
> +       select GENERIC_TIME
> +       select GENERIC_CLOCKEVENTS
> +       select HIGH_RES_TIMERS
> +       help
> +          Support for HRtimer and Dynamic Tick system using RTC and
> SYSTEM timer
> + 

Do you really need a config option for this? I mean HRT has a config
option already ..

Daniel
-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
