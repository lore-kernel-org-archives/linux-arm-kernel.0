From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 16 Oct 2015 22:08:59 +0200
Subject: [PATCH 2/5] ARM: berlin: remove the pinctrl selection from the
 mach-berlin Kconfig
In-Reply-To: <CACRpkdaa6sGvkZsdyc8M+nsooqUgz8g3-d1s7hET21ndBzCx7g@mail.gmail.com>
References: <1444771901-24460-1-git-send-email-antoine.tenart@free-electrons.com>
 <1444771901-24460-3-git-send-email-antoine.tenart@free-electrons.com>
 <CACRpkdaa6sGvkZsdyc8M+nsooqUgz8g3-d1s7hET21ndBzCx7g@mail.gmail.com>
Message-ID: <5621595B.2000809@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.10.2015 16:19, Linus Walleij wrote:
> On Tue, Oct 13, 2015 at 11:31 PM, Antoine Tenart
> <antoine.tenart@free-electrons.com> wrote:
>
>> This patch removes the pinctrl driver selection from the mach-berlin
>> Kconfig file. This is now done in the Berlin pinctrl driver Kconfig.
>>
>> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> I can't merge this patch, take it through ARM SoC with other
> Marvell stuff.

Applied to berlin/soc with Linus' Ack.

Thanks,
   Sebastian
