From: qnguyen@apm.com (Quan Nguyen)
Date: Fri, 19 Feb 2016 20:45:30 +0700
Subject: [PATCH v7 1/3] gpio: xgene: Enable X-Gene standby GPIO as
 interrupt controller
In-Reply-To: <CACRpkdaH7CLZDK9HP1nCYioPVbypQsZ76ZJcPMPLjVzV-DWqDQ@mail.gmail.com>
References: <1455714909-3027-1-git-send-email-qnguyen@apm.com>
 <1455714909-3027-2-git-send-email-qnguyen@apm.com>
 <CACRpkdaH7CLZDK9HP1nCYioPVbypQsZ76ZJcPMPLjVzV-DWqDQ@mail.gmail.com>
Message-ID: <CAFopSPROXiFd+7cfMQi2bwMfUBAoYEH=6m8qcvTdZ9n-mjiP1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Linus and Marc.

On Fri, Feb 19, 2016 at 4:11 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Feb 17, 2016 at 2:15 PM, Quan Nguyen <qnguyen@apm.com> wrote:
>
>> Enable X-Gene standby GPIO controller as interrupt controller to provide
>> its own resources. This avoids ambiguity where GIC interrupt resource is
>> use as X-Gene standby GPIO interrupt resource in user driver.
>>
>> Signed-off-by: Y Vo <yvo@apm.com>
>> Signed-off-by: Quan Nguyen <qnguyen@apm.com>
>> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
>
> Sweet! Patch applied.
>
> Yours,
> Linus Walleij
