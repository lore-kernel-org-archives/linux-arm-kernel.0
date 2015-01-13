From: olof@lixom.net (Olof Johansson)
Date: Mon, 12 Jan 2015 18:05:48 -0800
Subject: [PATCH 2/2] arm: dts: disable CCI on exynos420 based arndale-octa
In-Reply-To: <1420859496-27533-2-git-send-email-a.kesavan@samsung.com>
References: <1420859496-27533-1-git-send-email-a.kesavan@samsung.com>
 <1420859496-27533-2-git-send-email-a.kesavan@samsung.com>
Message-ID: <20150113020548.GC28758@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 10, 2015 at 08:41:36AM +0530, Abhilash Kesavan wrote:
> The arndale-octa board was giving "imprecise external aborts" during
> boot-up with MCPM enabled. CCI enablement of the boot cluster was found
> to be the cause of these aborts (possibly because the secure f/w was not
> allowing it). Hence, disable CCI for the arndale-octa board.
> 
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Tested-by: Kevin Hilman <khilman@linaro.org>
> Tested-by: Tyler Baker <tyler.baker@linaro.org>

Applied 1-2 to fixes for 3.19.

Fixed two typos (arm->ARM in subject, and 420->5420).


Thanks,

-Olof
