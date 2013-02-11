From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 11 Feb 2013 09:55:53 +0530
Subject: [PATCH v8 01/12] gpio: add gpio offset in gpio range cells
 property
In-Reply-To: <CACRpkdagbSMkvsdSrQakUsoSXy7gu0Fu1an09GBD_CizN0FDTw@mail.gmail.com>
References: <1359825953-15663-1-git-send-email-haojian.zhuang@linaro.org>
 <1359825953-15663-2-git-send-email-haojian.zhuang@linaro.org>
 <CACRpkdagbSMkvsdSrQakUsoSXy7gu0Fu1an09GBD_CizN0FDTw@mail.gmail.com>
Message-ID: <CAOh2x=ngXmmi+2+0750=QiEC58DR-0T=nzby9OwTpU=8DsC41A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 11, 2013 at 12:33 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Sat, Feb 2, 2013 at 6:25 PM, Haojian Zhuang
> <haojian.zhuang@linaro.org> wrote:
>
>> Add gpio offset into "gpio-range-cells" property. It's used to support
>> sparse pinctrl range in gpio chip.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>
> Can't decide on this thing, no reply from Shiraz.
>
> Viresh, what is your opinion?

Sorry for missing this thread earlier. Looks fine to me:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
