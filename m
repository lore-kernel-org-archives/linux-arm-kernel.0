From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed, 12 Dec 2012 11:29:11 +0100
Subject: [PATCH 05/12] ARM: OMAP3xxx: PM: convert to use the functional
 power states API
In-Reply-To: <20121209175312.6933.92995.stgit@dusk.lan>
References: <20121209174545.6933.59371.stgit@dusk.lan>
 <20121209175312.6933.92995.stgit@dusk.lan>
Message-ID: <CAORVsuWzg7es6rv15+-aGBkwXSZ4Pbd4Kz3qp_aej8vk9t=TxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul,

-resending in plain text only, sorry about that-

On Sun, Dec 9, 2012 at 6:53 PM, Paul Walmsley <paul@pwsan.com> wrote:
>
> From: Jean Pihet <jean.pihet@newoldbits.com>
>
> Use the functional power states as the API to control power domains:
>
> - use the PWRDM_FUNC_PWRST_* macros for the power states and logic
>   settings,
>
> - the function pwrdm_set_next_fpwrst(), which controls the power domains
>   next power and logic settings, shall be used instead of
>   pwrdm_set_next_pwrst() to program the power domains next states,
>
> - the function pwrdm_set_fpwrst(), which programs the power domains
>   power and logic settings, shall be used instead of
>   omap_set_pwrdm_state().
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> [paul at pwsan.com: split the original patch into OMAP2/3/4 variants;
>  clean up omap3_save_secure_ram_context(); fix commit message;
>  warn if sets fail; various other changes]


There are a lot of 'XXX' comments, can this be fixed by a proper comment?

Regards,
Jean
