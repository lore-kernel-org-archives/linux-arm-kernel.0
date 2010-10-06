From: viresh.kumar@st.com (viresh kumar)
Date: Wed, 6 Oct 2010 12:41:56 +0530
Subject: [PATCH V2 21/69] Keyboard: Adding support for spear-keyboard
In-Reply-To: <20101006061652.GA14609@core.coreip.homeip.net>
References: <cover.1285933331.git.viresh.kumar@st.com>
	<584e4ecc7883807e1fae0e6c53b2837954935e53.1285933331.git.viresh.kumar@st.com>
	<20101005154737.GA19730@core.coreip.homeip.net>
	<4CABF3E0.8010909@st.com>
	<20101006061652.GA14609@core.coreip.homeip.net>
Message-ID: <4CAC213C.9080506@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/2010 11:46 AM, Dmitry Torokhov wrote:
> Sorry, did not look far enough in the patch and missed the separate
> allocation. But do you really want to allocate it separately? I think
> the following patch simplifies and speeds up things at the expense of
> slightly larger keymap structure.
> 
> There are also fixes for proper __devinit/__devexit markups, locking of
> open/close vs suspend/resume, keymap can be changed from userspace via
> EVIOCSKEYCODE and bunch of other changes.
> 
> Thanks.
> 
> --
> Dmitry
> 
> 
> Input: spear-kbd - assorted changes
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> 
>  arch/arm/plat-spear/include/plat/keyboard.h |    3
>  drivers/input/keyboard/spear-keyboard.c     |  311 +++++++++++++--------------
>  2 files changed, 149 insertions(+), 165 deletions(-)

Dmitry,

We are busy with other activities, and can't test it right now.
But i have reviewed it and it looks fine to me.

Acked-by: Viresh Kumar <viresh.kumar@st.com>

Please include it in input-next repo. We will test it later on.

--
viresh
