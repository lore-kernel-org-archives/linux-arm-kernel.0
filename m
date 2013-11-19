From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 19 Nov 2013 12:33:21 +0400
Subject: [PATCH RESEND] arm: pxa: tosa: fix keys mapping
In-Reply-To: <20131116124750.GA26318@anuminas.rup.mentorg.com>
References: <20131116124750.GA26318@anuminas.rup.mentorg.com>
Message-ID: <CALT56yOcUChApUP6rOyXqWuK55ZR0Ooj457XVP2b7bVR9yk-8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sat, Nov 16, 2013 at 4:47 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> When converting from tosa-keyboard driver to matrix keyboard, tosa keys
> received extra 1 column shift. Replace that with correct values to make
> keyboard work again.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  arch/arm/mach-pxa/tosa.c | 102 +++++++++++++++++++++++------------------------
>  1 file changed, 51 insertions(+), 51 deletions(-)

As nobody seems to object, I would like to use my tosa maintainer
powers and push
this patch for inclusion.

Both Eric and Haojian seem to be unresponsive now.
Russell, can I push it to your patch system? Or should I push it to
arm-soc guys?

-- 
With best wishes
Dmitry
