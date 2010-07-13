From: viresh.kumar@st.com (Viresh KUMAR)
Date: Tue, 13 Jul 2010 16:37:47 +0530
Subject: [PATCH RESEND padmux.c] Fix typo in kerneldoc
In-Reply-To: <1279014561.18280.0.camel@cowboy>
References: <1279014561.18280.0.camel@cowboy>
Message-ID: <4C3C4903.7010201@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/13/2010 3:19 PM, Davidlohr Bueso wrote:
> Trivial fix in a typo (enalbed for enabled).
> 
> Thanks,
> Davidlohr
> 
> 
> Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> ---
>  arch/arm/plat-spear/padmux.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-spear/padmux.c b/arch/arm/plat-spear/padmux.c
> index d2aab3a..555eec6 100644
> --- a/arch/arm/plat-spear/padmux.c
> +++ b/arch/arm/plat-spear/padmux.c
> @@ -66,7 +66,7 @@ static int pmx_mode_set(struct pmx_mode *mode)
>   * If peripheral is not supported by current mode then request is rejected.
>   * Conflicts between peripherals are not handled and peripherals will be
>   * enabled in the order they are present in pmx_dev array.
> - * In case of conflicts last peripheral enalbed will be present.
> + * In case of conflicts last peripheral enabled will be present.
>   * Returns -ve on Err otherwise 0
>   */
>  static int pmx_devs_enable(struct pmx_dev **devs, u8 count)

Acked-by: Viresh Kumar <viresh.kumar@st.com>
