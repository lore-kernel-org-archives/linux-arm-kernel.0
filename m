From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 03 Feb 2015 16:44:26 +0800
Subject: [PATCH v8 20/21] Documentation: ACPI for ARM64
In-Reply-To: <54CFC97C.3080402@codeaurora.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-21-git-send-email-hanjun.guo@linaro.org>
 <54CFC97C.3080402@codeaurora.org>
Message-ID: <54D08A6A.80301@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?02?03? 03:01, Timur Tabi wrote:
> On 02/02/2015 06:45 AM, Hanjun Guo wrote:
>> From: Graeme Gregory <graeme.gregory@linaro.org>
>>
>> Add documentation for the guidelines of how to use ACPI
>> on ARM64.
>
> This patch has a slight corruption to it:
>
> In-Reply-To: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
> References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
> MIME-Version: 1.0
> Content-Type: text/plain; charset=n
>                                    ^
> git-am chokes on this:
>
>      fatal: cannot convert from n to UTF-8
>
> Replacing the 'n' with '"us-ascii"' fixes it.
>
> Patch #21 has the same problem, although it also has a trailing
> whitespace problem.

Hi Timur, I will fix that in next version.

Thanks
Hanjun
