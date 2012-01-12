From: lauri.hintsala@bluegiga.com (Lauri Hintsala)
Date: Thu, 12 Jan 2012 12:28:11 +0200
Subject: mxs-auart serial driver DMA support?
In-Reply-To: <20120112094244.GA2775@pengutronix.de>
References: <4F0E7EB0.2060906@bluegiga.com>
 <20120112094244.GA2775@pengutronix.de>
Message-ID: <4F0EB5BB.1060008@bluegiga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/2012 11:42 AM, Wolfram Sang wrote:
>
>> Any plans to add DMA support for mxs-auart serial driver? I noticed
>> it is impossible to archive full 3.25 Mbs speed with current one.
>
> No plans from our side, currently.

OK, AUART works fine with 115200 bps but over that it loose data 
randomly. I have seen fifo overrun errors during receiving data with 
1Mbs and over. So current driver is unuseful with higher baud rates.

Regards,
Lauri
