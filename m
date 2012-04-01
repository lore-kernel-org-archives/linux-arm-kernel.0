From: cjb@laptop.org (Chris Ball)
Date: Sat, 31 Mar 2012 23:44:41 -0400
Subject: [PATCH 3/3] mmc: atmel-mci: add support for odd clock dividers
In-Reply-To: <4F6B3BD0.4060702@atmel.com> (Nicolas Ferre's message of "Thu, 22
 Mar 2012 15:48:48 +0100")
References: <1332344483-3915-1-git-send-email-ludovic.desroches@atmel.com>
 <1332344483-3915-4-git-send-email-ludovic.desroches@atmel.com>
 <4F6B3BD0.4060702@atmel.com>
Message-ID: <87mx6wm7yu.fsf@laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 22 2012, Nicolas Ferre wrote:
> On 03/21/2012 04:41 PM, ludovic.desroches at atmel.com :
>> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>> 
>> Add an odd clock divider capability available from v5xx. It also involves
>> changing the clock divider calculation.
>
> Also tell here that you have changed the way that the switch/case
> directive has been implemented.
>
>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> Otherwise:
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks, pushed to mmc-next for 3.4 with a rewording:

    Add an odd clock divider capability available from v5xx. It also involves
    changing the clock divider calculation, and changing the switch-case
    statement to use top-down fallthrough.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
