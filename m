From: dv@vollmann.ch (Detlef Vollmann)
Date: Thu, 21 Apr 2011 02:56:31 +0200
Subject: [RFC PATCH 00/23] at91: Replace duplicate device initialisation
	code	with common code
In-Reply-To: <4DAF4B08.3000601@bluewatersys.com>
References: <1303261827-27730-1-git-send-email-ryan@bluewatersys.com>	<0D753D10438DA54287A00B027084269764D23AB87B@AUSP01VMBX24.collaborationhost.net>
	<4DAF4B08.3000601@bluewatersys.com>
Message-ID: <4DAF80BF.5070209@vollmann.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/20/11 23:07, Ryan Mallon wrote:
> On 04/21/2011 05:14 AM, H Hartley Sweeten wrote:
>> On Tuesday, April 19, 2011 6:10 PM, Ryan Mallon wrote:
>>>    at91: Make UART devices common
>> This patch (12/23) appears to be missing.
>>
>
> I got a message saying that it is being held for moderator approval
> because it was over the size limit. The diffstat for it is below in the
> meantime.
Is there a chance you can resend it, cc-ing the interested parties
(including me), just in case the moderator doesn't look at it
before the Easter weekend?
We had to apply some patches to the UART setup of at91sam9260_devices.c
and at91sam9g45_devices.c, and I'd like to check over the Easter
holidays that we can apply a similar patch to your new setup.

   Detlef
