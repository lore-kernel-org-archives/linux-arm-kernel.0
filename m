From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Tue, 4 Nov 2014 11:23:46 -0600
Subject: [PATCH] ARM: make kuser helpers depend on MMU
In-Reply-To: <20141104080353.GX8316@pengutronix.de>
References: <1415045178-4673-1-git-send-email-nathan_lynch@mentor.com>
 <20141104080353.GX8316@pengutronix.de>
Message-ID: <54590BA2.9070101@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/2014 02:03 AM, Uwe Kleine-K?nig wrote:
> On Mon, Nov 03, 2014 at 02:06:18PM -0600, Nathan Lynch wrote:
>>
>> Prevent CONFIG_MMU=n configurations from enabling
>> CONFIG_KUSER_HELPERS.
>>
>> Fixes: fbfb872f5f41 ARM: 8148/1: flush TLS and thumbee register state during exec
> minor nit: Usual syntax here is:
> 
> 	Fixes: fbfb872f5f41 ("ARM: 8148/1: flush ...")
> 
>>
> and it's part of the s-o-b area, so no empty line

Indeed, will fix before sending to the patch tracker.

> 
>> Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
>> Reported-by: Stefan Agner <stefan@agner.ch>
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks.
