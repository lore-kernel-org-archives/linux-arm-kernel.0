From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 14 Dec 2011 18:18:00 +0100
Subject: [PATCH] ux500: remove overlapping iotable entries
In-Reply-To: <alpine.LFD.2.02.1112141151490.2907@xanadu.home>
References: <1323850933-3084-1-git-send-email-linus.walleij@stericsson.com>
 <alpine.LFD.2.02.1112141151490.2907@xanadu.home>
Message-ID: <CACRpkdadPTVrBLSWRftf_Hw2q1N2HFqKZyiJL7gS42THMA4=uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 5:53 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Wed, 14 Dec 2011, Linus Walleij wrote:
>
>> The overlapping iotable mapping entries for the ux500 Cortex
>> A9 SCU, CPU control and TWD are no longer accepted by the
>> kernel. Remove the overlaps so the machine boots again.
>>
>> Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
>> Cc: Rabin Vincent <rabin.vincent@stericsson.com>
>> Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Reported-by: Nicolas Pitre <nicolas.pitre@linaro.org>
>> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
>
> Acked-by: Nicolas Pitre <nico@linaro.org>
>
> Please put this into RMK's patch system so he could merge it into his
> devel-stable branch where the issue comes from.

OK it's 7233/1.

Thanks,
Linus Walleij
