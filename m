From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 26 Nov 2013 14:12:17 +0400
Subject: [PATCH 0/6] arm: sa1100: refactor h3xxx GPIO handling
In-Reply-To: <CACRpkdbNSMGWPjFVRNBmUfL2i=LEwv7kLSbo09SM-gP0JZ3Ppg@mail.gmail.com>
References: <1385048414-9812-1-git-send-email-dbaryshkov@gmail.com>
 <CACRpkdbNSMGWPjFVRNBmUfL2i=LEwv7kLSbo09SM-gP0JZ3Ppg@mail.gmail.com>
Message-ID: <CALT56yOr+qb9-hfeg3Qu2aJQgBy08c6kmdpPVTGvLL6R79=F3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Nov 26, 2013 at 12:49 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Thu, Nov 21, 2013 at 4:40 PM, Dmitry Eremin-Solenikov
> <dbaryshkov@gmail.com> wrote:
>
>> I have been thinking abbout h3100/h3600 and GPIO issues.Could you please
>> review and test these patches. It is an attempt to cleanup and refactor GPIO
>> handling not to call gpio_request at init_machine time.
>
> Tested on the h3600 and works flawlessly!
>
> Tested-by: Linus Walleij <linus.walleij@linaro.org>

Thank you!



-- 
With best wishes
Dmitry
