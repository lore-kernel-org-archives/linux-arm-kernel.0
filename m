From: b32955@freescale.com (Huang Shijie)
Date: Thu, 31 Mar 2011 18:09:05 +0800
Subject: [PATCH 5/7] add GPMI support for imx28
In-Reply-To: <1301564849.2828.26.camel@localhost>
References: <1300240521-4344-1-git-send-email-b32955@freescale.com>	
	<1300240521-4344-6-git-send-email-b32955@freescale.com>
	<1301564849.2828.26.camel@localhost>
Message-ID: <4D9452C1.4020200@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi:
> On Wed, 2011-03-16 at 09:55 +0800, Huang Shijie wrote:
>> +#define BF_BCH_CTRL_RSVD5(v)  \
>> +               (((v)<<  23)&  BM_BCH_CTRL_RSVD5)
> Many lines where you used "\" fit 80 lines. Just do not use tabs between
> name and value (which is ugly, imo), use a space and then it fits 80
> lines. This neater than splitting things on 2 lines.
>
Please check the latest version of the driver.
The code has been remove in new version.

Best Regards
Huang Shijie
