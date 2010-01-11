From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 11 Jan 2010 15:43:30 -0500
Subject: [PATCH] ep93xx: define magic numbers for pll1 and pll2
In-Reply-To: <4B4B7F6E.5010304@bluewatersys.com>
References: <BD79186B4FD85F4B8E60E381CAEE19090200F622@mi8nycmail19.Mi8.com>
	<4B4A795C.8000507@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE190902089912@mi8nycmail19.Mi8.com>
	<4B4B7F6E.5010304@bluewatersys.com>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190902089960@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, January 11, 2010 12:44 PM, Ryan Mallon wrote:
> H Hartley Sweeten wrote:
>> On Sunday, January 10, 2010 6:06 PM, Ryan Mallon wrote:
>>> H Hartley Sweeten wrote:
>>>> Add defines for the pll register magic numbers that determine if
>>>> the pll's are bypassed and if pll2 is enabled.  Rename the clock
>>>> set registers to more closely match the datasheet.  Also, remove
>>>> the unnecessary braces since each conditional statement is a single
>>>> statement.
>>>>
>>>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>>>> Cc: Ryan Mallon <ryan@bluewatersys.com>
>>>>
>>>> ---
>>>>

Acked-by: Ryan Mallon <ryan@bluewatersys.com>

Thanks. This and the other ones are now in the patch system.

Regards,
Hartley
