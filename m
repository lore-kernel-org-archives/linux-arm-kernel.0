From: jonathan.austin@arm.com (Jonathan Austin)
Date: Mon, 11 Nov 2013 18:40:52 +0000
Subject: [PATCH 1/2] ARM: integrator_cp: Set LCD{0,1} enable lines when
 turning on CLCD
In-Reply-To: <20130910003508.GB31153@quad.lixom.net>
References: <1377798071-26790-1-git-send-email-jonathan.austin@arm.com>
 <20130910003508.GB31153@quad.lixom.net>
Message-ID: <528124B4.8060408@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On 10/09/13 01:35, Olof Johansson wrote:
> On Thu, Aug 29, 2013 at 06:41:11PM +0100, Jonathan Austin wrote:
>> This turns on the internal integrator LCD display(s). It seems that the code
>> to do this got lost in refactoring of the CLCD driver.
>>
>> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>> Cc: stable at vger.kernel.org
>>
>> ---
>> ...resending this patch to arm at kernel.org as suggested by Linus W with this Ack
>
> Applied to fixes.
>

How will this go in? I poked in your arm-soc fixes branches and couldn't 
see it there. Did I miss it somewhere or did it fall out?

Jonny

>
> -Olof
>
