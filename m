From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 10 Mar 2013 08:27:16 +0530
Subject: [PATCH] ARM:vexpress: beautify code, using 'static const' instead
 of 'const static'
In-Reply-To: <513BF001.30204@asianux.com>
References: <513BF001.30204@asianux.com>
Message-ID: <CAKohpon1G9hei1QcCyEAYCdxY-pYJ5GCD31yoEmNSVTpnLh15g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 March 2013 07:59, Chen Gang <gang.chen@asianux.com> wrote:
>
>   better using 'static const' instead of 'const static'
>
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/arm/mach-vexpress/platsmp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
> index dc1ace5..9152bf7 100644
> --- a/arch/arm/mach-vexpress/platsmp.c
> +++ b/arch/arm/mach-vexpress/platsmp.c
> @@ -40,7 +40,7 @@ static struct map_desc vexpress_dt_cortex_a9_scu_map __initdata = {
>
>  static void *vexpress_dt_cortex_a9_scu_base __initdata;
>
> -const static char *vexpress_dt_cortex_a9_match[] __initconst = {
> +static const char *vexpress_dt_cortex_a9_match[] __initconst = {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
