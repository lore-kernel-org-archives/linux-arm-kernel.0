From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Sat, 27 Jun 2015 11:29:12 +0530
Subject: [PATCH] mfd: 880m80x: Make use of BIT() macro
In-Reply-To: <CAJKOXPd3Wjs2+yFpruxMKQmjVD1+h0QPHD8TC-0YLrXhnxUkbQ@mail.gmail.com>
References: <1435324091-2196-1-git-send-email-vaibhav.hiremath@linaro.org>
 <CAJKOXPd3Wjs2+yFpruxMKQmjVD1+h0QPHD8TC-0YLrXhnxUkbQ@mail.gmail.com>
Message-ID: <558E3BB0.8020308@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Saturday 27 June 2015 11:06 AM, Krzysztof Kozlowski wrote:
> 2015-06-26 22:08 GMT+09:00 Vaibhav Hiremath <vaibhav.hiremath@linaro.org>:
>> Instead of hard coding the shift for bit definition, use
>> BIT() macro.
>
> I am not convinced that such change improves anything in existing
> code. IMHO (1 << n) is quite readable and obvious. The obviousness of
> it, is the same as obviousness of BIT(n). However I know that Lee
> Jones likes the BIT() so it's up to him :) .
>
> In the same time you are cleaning a little the indentation in defines
> which is nice, but messes with main change. It is difficult to find
> the exact differences, to review it. Can you split the patch into two
> commits - one for BIT (if this is desired by Lee Jones) and one for
> white space clean up?
>

White spaces changes are not much...

Thanks,
Vaibhav
