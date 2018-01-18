From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 18 Jan 2018 20:57:37 +0530
Subject: [PATCH v5 43/44] ARM: da8xx-dt: switch to device tree clocks
In-Reply-To: <1515378307-23718-4-git-send-email-david@lechnology.com>
References: <1515378307-23718-1-git-send-email-david@lechnology.com>
 <1515378307-23718-4-git-send-email-david@lechnology.com>
Message-ID: <8b30f1e6-74dc-3fd6-71a6-c9ceaf77a9d1@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 January 2018 07:55 AM, David Lechner wrote:
> This removes all of the clock init code from da8xx-dt.c. This includes
> all of the OF_DEV_AUXDATA that was just used for looking up clocks.
> 
> Note: You need to have clocks defined in your device tree or your system
> won't boot after this patch.

I am not sure we can do this then, as we cannot break DT compatibility.

Thanks,
Sekhar
