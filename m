From: richard.genoud@gmail.com (Richard Genoud)
Date: Wed, 02 Apr 2014 17:09:03 +0200
Subject: [PATCH v6 1/3] tty/serial: Add GPIOLIB helpers for controlling
 modem lines
In-Reply-To: <20140317232359.GA8943@kroah.com>
References: <1394469951-21192-1-git-send-email-richard.genoud@gmail.com>
 <1394469951-21192-2-git-send-email-richard.genoud@gmail.com>
 <20140317232359.GA8943@kroah.com>
Message-ID: <533C280F.3060804@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/03/2014 00:23, Greg Kroah-Hartman wrote:
> On Mon, Mar 10, 2014 at 05:45:49PM +0100, Richard Genoud wrote:
>> This patch add some helpers to control modem lines (CTS/RTS/DSR...) via
>> GPIO.
>> This will be useful for many boards which have a serial controller that
>> only handle CTS/RTS pins (or even just RX/TX).
>>
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> I can't take this series through my tty tree as the non-tty patches
> don't apply, so feel free to take them through whatever tree is needed.
> 
> greg k-h
> 

I guess this series won't make it for 3.15, as it doesn't apply on any tree.
However, I'd like to know if I did something wrong, or if there's no
solution when a series depends on several patches that are in different
trees ?

Richard.
