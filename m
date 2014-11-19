From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 19 Nov 2014 14:04:58 -0200
Subject: [PATCH] thermal: sti: Ignore suspend/resume functions when !PM
In-Reply-To: <1416412231-2752-1-git-send-email-lee.jones@linaro.org>
References: <1416412231-2752-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CAOMZO5CwFSRUoVb2j=X=fzaqVN1gUyRki70ewrGrwqLWSHMoAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 19, 2014 at 1:50 PM, Lee Jones <lee.jones@linaro.org> wrote:
> Prevents build warning:
>
> st_thermal.c:278:12:
>     warning: ?st_thermal_suspend? defined but not used [-Wunused-function]
> st_thermal.c:286:12:
>     warning: ?st_thermal_resume? defined but not used [-Wunused-function]
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>
> v1 => v2:
>  - CONFIG_PM => CONFIG_PM_SLEEP suggested by David Paris.

You should also update the Subject to 'when !PM_SLEEP'
