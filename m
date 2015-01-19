From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 19 Jan 2015 11:18:31 +0100
Subject: [PATCH v3 4/4] pinctrl: qcom: Add support for reset for apq8064
In-Reply-To: <54B7086E.7060807@codeaurora.org>
References: <1409322659-17693-1-git-send-email-pramod.gurav@smartplayin.com>
 <1409322659-17693-5-git-send-email-pramod.gurav@smartplayin.com>
 <CAOZdJXXRgrYUEcX4f5zRuKgX-Dtbpvf-SV4-8rjuohv3=0NJhQ@mail.gmail.com>
 <54B6FF75.70500@codeaurora.org>
 <CAOZdJXXZ3RH1zOGcz1L58d9DV_LSZtUxYVKe6ssM71nyhnbMyg@mail.gmail.com>
 <54B7086E.7060807@codeaurora.org>
Message-ID: <CACRpkdaY_6vdY+d0mmce75q7Gh_Jku1MtVuYeus9EO0LfgDHng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 15, 2015 at 1:23 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 01/14/2015 03:54 PM, Timur Tabi wrote:
>> On Wed, Jan 14, 2015 at 5:44 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>>> I think so. Can you send a patch? Plus it would be nice to move i = 0 in
>>> the for loop at the same time.
>> Sadly, Qualcomm policy makes that very cumbersome for me.  I won't be
>> able to send a patch any time soon.
>>
>
> Hm... we'll have to figure out that part. Anyway here's the patch.
>
> ---8<----
> From: Stephen Boyd <sboyd@codeaurora.org>
> Subject: [PATCH] pinctrl: qcom: Don't iterate past end of function array
>
> Timur reports that this code crashes if nfunctions is 0. Fix the
> loop iteration to only consider valid elements of the functions
> array.
>
> Reported-by: Timur Tabi <timur@codeaurora.org>
> Cc: Pramod Gurav <pramod.gurav@smartplayin.com>
> Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Cc: Ivan T. Ivanov <iivanov@mm-sol.com>
> Cc: Andy Gross <agross@codeaurora.org>
> Fixes: 327455817a92 "pinctrl: qcom: Add support for reset for apq8064"
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

This patch applied for fixes.

Yours,
Linus Walleij
