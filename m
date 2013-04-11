From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Thu, 11 Apr 2013 12:40:14 -0400
Subject: [v2,06/14] thermal: mvebu: Fix license declaration
In-Reply-To: <1363991114-4225-7-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1363991114-4225-7-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <5166E76E.5020104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rui,

On 22-03-2013 18:25, Ezequiel Garcia wrote:
> The license text declared in the header explicit says GPL v2 only,
> but the MODULE_LICENSE macro says GPL, which means GPL v2 or later. Fix it.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>

This specific patch is fine to me.

Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

> ---
> drivers/thermal/mvebu_thermal.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/thermal/mvebu_thermal.c b/drivers/thermal/mvebu_thermal.c
> index 2aeaf75..0c9344d 100644
> --- a/drivers/thermal/mvebu_thermal.c
> +++ b/drivers/thermal/mvebu_thermal.c
> @@ -128,4 +128,4 @@ module_platform_driver(mvebu_thermal_driver);
>
>   MODULE_AUTHOR("Nobuhiro Iwamatsu <iwamatsu@nigauri.org>");
>   MODULE_DESCRIPTION("mvebu thermal driver");
> -MODULE_LICENSE("GPL");
> +MODULE_LICENSE("GPL v2");
>

Side question, while here:
Ezequiel, does this driver need a MODULE_ALIAS
