From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 01 Dec 2014 10:50:29 -0800
Subject: [PATCH RFT 2/2] arm: dts: disable CCI on exynos420 based
 arndale-octa
In-Reply-To: <1417186209-5256-2-git-send-email-a.kesavan@samsung.com>
 (Abhilash Kesavan's message of "Fri, 28 Nov 2014 20:20:09 +0530")
References: <1417186209-5256-1-git-send-email-a.kesavan@samsung.com>
 <1417186209-5256-2-git-send-email-a.kesavan@samsung.com>
Message-ID: <7hbnnn5hmy.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Abhilash Kesavan <a.kesavan@samsung.com> writes:

> The arndale-octa board was giving "imprecise external aborts" during
> boot-up with MCPM enabled. CCI enablement of the boot cluster was found
> to be the cause of these aborts (possibly because the secure f/w was not
> allowing it). Hence, disable CCI for the arndale-octa board.
>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>

Tested-by: Kevin Hilman <khilman@linaro.org>

Tested on top of next-20141128 with exynos_defconfig on my Octa board
and I'm not seeing the imprecise aborts anymore.  

Thanks,

Kevin
