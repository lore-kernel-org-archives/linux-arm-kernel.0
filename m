From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 9 Jun 2011 16:26:08 -0500
Subject: [PATCH v2 1/5] ep93xx: set DMA masks for the ep93xx_eth
In-Reply-To: <20110609204113.GE2857@acer>
References: <f20d8fe52f823e7e65423720c53f2935d3e08967.1307040443.git.mika.westerberg@iki.fi>
	<ADE657CA350FB648AAC2C43247A983F001F3820B85F3@AUSP01VMBX24.collaborationhost.net>
	<20110609204113.GE2857@acer>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F3820B863A@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 09, 2011 1:41 PM, Mika Westerberg wrote:
> On Thu, Jun 09, 2011 at 03:27:11PM -0500, H Hartley Sweeten wrote:
>> On Thursday, June 02, 2011 12:00 PM, Mika Westerberg wrote:
>>>
>>> As the driver is now passing platform device to the DMA mapping functions,
>>> we should give it valid DMA masks.
>>>
>>> Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
>>> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> 
>> Since you made this patch the first in the series the commit message is not
>> quite right.  Other than that:
>> 
>> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>
> Ah, right. I forgot to change the commit message. How about following?
>
> From: Mika Westerberg <mika.westerberg@iki.fi>
> Subject: [PATCH 1/5] ep93xx: set DMA masks for the ep93xx_eth
>
> Since the driver uses the DMA API, we should pass it valid DMA masks.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

I like that better.

Thanks,
Hartley
