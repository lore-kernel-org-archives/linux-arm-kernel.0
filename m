From: Thomas.Kunze@gmx.com (Thomas Kunze)
Date: Sun, 29 Nov 2009 12:44:42 +0100
Subject: [PATCH 6/9] add gpiolib support to ucb1x00
In-Reply-To: <20091128124751.GD25671@n2100.arm.linux.org.uk>
References: <1254778533-3529-1-git-send-email-thommycheck@gmx.de>	<1254778533-3529-2-git-send-email-thommycheck@gmx.de>	<1254778533-3529-3-git-send-email-thommycheck@gmx.de>	<1254778533-3529-4-git-send-email-thommycheck@gmx.de>	<1254778533-3529-5-git-send-email-thommycheck@gmx.de>	<1254778533-3529-6-git-send-email-thommycheck@gmx.de>	<1254778533-3529-7-git-send-email-thommycheck@gmx.de>
	<20091128124751.GD25671@n2100.arm.linux.org.uk>
Message-ID: <4B125EAA.20704@gmx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux schrieb:
> On Mon, Oct 05, 2009 at 11:35:30PM +0200, Thomas Kunze wrote:
>   
>> The old access methods to the gpios will be removed when
>> all users has been converted. (mainly ucb1x00-ts)
>>     
>
> btw, what was the point in moving private includes out of drivers/mfd
> into include/linux/mfd?  If they're private, they should stay private
> and local to the relevant files IMHO.
>   
I moved the touchscreen driver to drivers/input/touchscreen and the 
battery driver (in drivers/power) needs those too.
There is an out of tree sound driver for ucb1x00 thats in the sound 
directory. So moving those includes to a more accessable
location makes sense to me.

Regards,
Thomas
