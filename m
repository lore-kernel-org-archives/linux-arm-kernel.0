From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 23 Jan 2015 18:09:12 +0100
Subject: [PATCH V4 4/4] mmc: pwrseq_simple: Add support for a reset GPIO
 pin
In-Reply-To: <CAPDyKFqnU3OcyiDYPQ4pLRhOGkiEJ1nuwYSP_+qain63N9CEfg@mail.gmail.com>
References: <1421658784-11980-1-git-send-email-ulf.hansson@linaro.org>
 <1421658784-11980-5-git-send-email-ulf.hansson@linaro.org>
 <CABxcv=nGWPnkNz1tXJpaTUkroucDgVYzeCrEmZvA8xfzHzROvg@mail.gmail.com>
 <CAPDyKFqnU3OcyiDYPQ4pLRhOGkiEJ1nuwYSP_+qain63N9CEfg@mail.gmail.com>
Message-ID: <CABxcv=mGPm4GnFtKOY--Ev0fJEezM86-vfDrERMtaNJkjnTNmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ulf,

On Fri, Jan 23, 2015 at 6:01 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> Any reason to not use the devm_gpiod_get_index() managed version instead?
>
> This struct device don't have a bound driver to it. Thus this device
> won't be freed automagically from the ->remove() or failed ->probe()
> path.
>

Right, I missed that. Thanks a lot for the clarification.

Best regards,
Javier
