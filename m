From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 19 Dec 2013 21:15:39 +0100
Subject: [PATCH 22/41] clk: ux500: Copy u8500_clk_init() ready for DT
 enablement
In-Reply-To: <20131213015158.11981.27135@quantum>
References: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
 <1379506478-16625-23-git-send-email-lee.jones@linaro.org>
 <CACRpkdZ+kg8VEMZ6gy6CG=YK0Ycj-Ud-UuRohzKgE4UW_VUMjg@mail.gmail.com>
 <20131213015158.11981.27135@quantum>
Message-ID: <CAPDyKFoVDP=wcV0FcKYMtf-y8uq2ob2Ahge2y9_HL-bVojTcgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 December 2013 02:51, Mike Turquette <mturquette@linaro.org> wrote:
> Quoting Linus Walleij (2013-09-20 13:59:46)
>> On Wed, Sep 18, 2013 at 2:14 PM, Lee Jones <lee.jones@linaro.org> wrote:
>>
>> > Here we're using the old clock initialisation function as a template.
>> > It's necessary to remove all of the clk_register_clkdev() calls as
>> > they don't make sense when booting with Device Tree.
>> >
>> > Cc: Mike Turquette <mturquette@linaro.org>
>> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>
>> I *really* like the looks of this! Mike can we have your ACK on this?
>
> Acked-by: Mike Turquette <mturquette@linaro.org>

Hi Mike,

This went in through arm soc a while ago, it is present in 3.13 rc.
Thanks for your ack, anyway.

Kind regards
Uffe

>
>>
>> Yours,
>> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
