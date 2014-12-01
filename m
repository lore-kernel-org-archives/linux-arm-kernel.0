From: tyler.baker@linaro.org (Tyler Baker)
Date: Mon, 1 Dec 2014 11:52:20 -0800
Subject: [PATCH RFT 2/2] arm: dts: disable CCI on exynos420 based
 arndale-octa
In-Reply-To: <7hbnnn5hmy.fsf@deeprootsystems.com>
References: <1417186209-5256-1-git-send-email-a.kesavan@samsung.com>
 <1417186209-5256-2-git-send-email-a.kesavan@samsung.com>
 <7hbnnn5hmy.fsf@deeprootsystems.com>
Message-ID: <CANMBJr60MOoHfeSYJK2dN-oyJtLaFWQ3ubjXLQYKfj1WQ8Qb2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 December 2014 at 10:50, Kevin Hilman <khilman@kernel.org> wrote:
> Abhilash Kesavan <a.kesavan@samsung.com> writes:
>
>> The arndale-octa board was giving "imprecise external aborts" during
>> boot-up with MCPM enabled. CCI enablement of the boot cluster was found
>> to be the cause of these aborts (possibly because the secure f/w was not
>> allowing it). Hence, disable CCI for the arndale-octa board.
>>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>
> Tested-by: Kevin Hilman <khilman@linaro.org>
>
> Tested on top of next-20141128 with exynos_defconfig on my Octa board
> and I'm not seeing the imprecise aborts anymore.
>
> Thanks,
>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Tested-by: Tyler Baker <tyler.baker@linaro.org>

Tested on top of mainline/master with exynos_defconfig on my
arndale-octa board.
One hundred boots attempted with no imprecise aborts.

Cheers,

-- 
Tyler Baker
Tech Lead, LAVA
Linaro.org | Open source software for ARM SoCs
Follow Linaro: http://www.facebook.com/pages/Linaro
http://twitter.com/#!/linaroorg - http://www.linaro.org/linaro-blog
