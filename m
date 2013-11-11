From: olof@lixom.net (Olof Johansson)
Date: Mon, 11 Nov 2013 10:43:45 -0800
Subject: [PATCH 1/2] ARM: integrator_cp: Set LCD{0,1} enable lines when
 turning on CLCD
In-Reply-To: <528124B4.8060408@arm.com>
References: <1377798071-26790-1-git-send-email-jonathan.austin@arm.com>
 <20130910003508.GB31153@quad.lixom.net> <528124B4.8060408@arm.com>
Message-ID: <CAOesGMhxFexzZqnmeBYYvNROWo4N1CCa5vR_xNo2U7qZgvHORA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 11, 2013 at 10:40 AM, Jonathan Austin
<jonathan.austin@arm.com> wrote:
> Hi Olof,
>
>
> On 10/09/13 01:35, Olof Johansson wrote:
>>
>> On Thu, Aug 29, 2013 at 06:41:11PM +0100, Jonathan Austin wrote:
>>>
>>> This turns on the internal integrator LCD display(s). It seems that the
>>> code
>>> to do this got lost in refactoring of the CLCD driver.
>>>
>>> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
>>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>> Cc: stable at vger.kernel.org
>>>
>>> ---
>>> ...resending this patch to arm at kernel.org as suggested by Linus W with
>>> this Ack
>>
>>
>> Applied to fixes.
>>
>
> How will this go in? I poked in your arm-soc fixes branches and couldn't see
> it there. Did I miss it somewhere or did it fall out?


Hmm, odd. Yes, it did fall out. I'll re-apply it now for the next set
of patches we're sending up. Sorry about that.


-Olof
