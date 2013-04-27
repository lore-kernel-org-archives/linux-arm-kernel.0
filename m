From: olof@lixom.net (Olof Johansson)
Date: Fri, 26 Apr 2013 17:22:03 -0700
Subject: [PATCH] clk: add option to keep boot clocks on
In-Reply-To: <517B16FF.6070008@infradead.org>
References: <1367019591-31685-1-git-send-email-olof@lixom.net>
 <517B16FF.6070008@infradead.org>
Message-ID: <CAOesGMg0_Awi_b--tuEDFU8tZUqTA46RWuiiBP7=ct00O7zcEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 26, 2013 at 5:08 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 04/26/13 16:39, Olof Johansson wrote:
>> This is primarily useful when there's a driver that doesn't claim clocks
>> properly, but the bootloader does. It's not expected to be used in normal
>> cases, but for bringup and debug it's very useful to have the option to
>> not gate unclaimed clocks that are still on.
>>
>> Signed-off-by: Olof Johansson <olof@lixom.net>
>
> add to Documentation/kernel-parameters.txt or somewhere else?

Ah, yes, of course. I'll wait for Mike to provide input on the color
of the shed, since it might change location in the file if it's
renamed. And then repost with documentation update.


-Olof
