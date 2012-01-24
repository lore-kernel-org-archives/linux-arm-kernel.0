From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Tue, 24 Jan 2012 15:19:46 +0530
Subject: [PATCH RFC 1/2] watchdog : omap_wdt : Implement
 WDIOC_GETBOOTSTATUS for omap3+
In-Reply-To: <20120124093318.GA2609@pengutronix.de>
References: <1327317188-14782-1-git-send-email-shubhrajyoti@ti.com>
 <1327317188-14782-2-git-send-email-shubhrajyoti@ti.com>
 <B5906170F1614E41A8A28DE3B8D12143317901B9@DBDE01.ent.ti.com>
 <CAM=Q2ctL_Z5P6=NwAWBHD2bR=xqHMCF15g6v0Ap=hJMPdgXwyQ@mail.gmail.com>
 <B5906170F1614E41A8A28DE3B8D12143317902D6@DBDE01.ent.ti.com>
 <20120124093318.GA2609@pengutronix.de>
Message-ID: <4F1E7EBA.3090006@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 January 2012 03:03 PM, Wolfram Sang wrote:
>> Just returning the register content does not help much and looking at other
>> implementations, like Blackfin, I am guessing this IOCTL is supposed to give
>> a yes/no sort of result.
> It needs to return WDIOF_* flags as defined in include/linux/watchdog.h.
> Check also Documentation/watchdog/watchdog-api.txt for further info.
> Yes, not all drivers follow this style, sadly.
Yes I agree.
> Regards,
>
>    Wolfram
>
