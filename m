From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 8 Jun 2010 18:26:31 -0500
Subject: [PATCH 1/3] EP93xx: Add i2s core support
In-Reply-To: <4C0E9987.2010907@bluewatersys.com>
References: <1275991272-30122-1-git-send-email-ryan@bluewatersys.com>
	<1275991272-30122-2-git-send-email-ryan@bluewatersys.com>
	<0D753D10438DA54287A00B027084269763708AFD76@AUSP01VMBX24.collaborationhost.net>
	<4C0E9987.2010907@bluewatersys.com>
Message-ID: <0D753D10438DA54287A00B02708426976370DCDC51@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, June 08, 2010 12:27 PM, Ryan Mallon wrote:
> H Hartley Sweeten wrote:
>> On Tuesday, June 08, 2010 3:01 AM, Ryan Mallon wrote:
>>> Add core support for EP93xx i2s audio
>>>
>>> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
>> 
>> Looks good.
>> 
>> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> 
>
> Okay, I have Liam and Hartley's acks on this one and Liam's on 3/3.
> Mark, do you want to apply the other two patches to your tree, or should
> they go via the arm tree?

Ryan,

It appears Mark doesn't see ant reason to apply patch 1 to his tree.  It's
probably better to send that one thru Russell's patch system in case any
other changes are made to the ep93xx core files.

Regards,
Hartley
