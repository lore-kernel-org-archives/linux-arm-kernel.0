From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 19 Dec 2014 17:21:58 +0100
Subject: [PATCH] clk: samsung: exynos7: Add clocks for MSCL block
In-Reply-To: <1418801617-7593-1-git-send-email-tony.kn@samsung.com>
References: <1418801617-7593-1-git-send-email-tony.kn@samsung.com>
Message-ID: <549450A6.9020205@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 17/12/14 08:33, Tony K Nadackal wrote:
> Add clock support for the MSCL block for Exynos7.
> 
> Signed-off-by: Tony K Nadackal <tony.kn@samsung.com>
> ---
>  .../devicetree/bindings/clock/exynos7-clock.txt    |   1 +
>  drivers/clk/samsung/clk-exynos7.c                  | 124 +++++++++++++++++++++
>  include/dt-bindings/clock/exynos7-clk.h            |  40 ++++++-
>  3 files changed, 164 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/exynos7-clock.txt b/Documentation/devicetree/bindings/clock/exynos7-clock.txt
> index 6d3d5f8..d0e048c 100644
> --- a/Documentation/devicetree/bindings/clock/exynos7-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/exynos7-clock.txt
> @@ -34,6 +34,7 @@ Required Properties for Clock Controller:
>  	- "samsung,exynos7-clock-peris"
>  	- "samsung,exynos7-clock-fsys0"
>  	- "samsung,exynos7-clock-fsys1"
> +	- "samsung,exynos7-clock-mscl"

I can't see anything controversial in the patch, but I've got some doubts
regarding the compatible string. Is there a SoC named just "Exynos7"?
If not, what are exact SoC names the "samsung,exynos7-clock-mscl" compatible
is supposed to cover ?
It would be good to list in this file the exact SoCs names this binding applies
to, unless there is indeed Exynos7 SoC.

--
Thanks,
Sylwester
