From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 11 Dec 2012 09:54:33 +0000
Subject: [PATCH 06/12] ARM: ux500: Set correct MMCI regulator voltages in
 the ux5x0 Device Tree
In-Reply-To: <CAPDyKFo6KhshYJfSvodPK4e7zC25etz0G8fV4jnAssZX3BDZBg@mail.gmail.com>
References: <1355129761-8088-1-git-send-email-lee.jones@linaro.org>
 <1355129761-8088-7-git-send-email-lee.jones@linaro.org>
 <CACRpkdZJFbHSwowKnfWyXLckVePHrC6o2CtDJaFb+dXTkNYPjw@mail.gmail.com>
 <CAPDyKFo6KhshYJfSvodPK4e7zC25etz0G8fV4jnAssZX3BDZBg@mail.gmail.com>
Message-ID: <20121211095433.GK9362@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Dec 2012, Ulf Hansson wrote:

> On 11 December 2012 10:17, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Mon, Dec 10, 2012 at 9:55 AM, Lee Jones <lee.jones@linaro.org> wrote:
> >
> >> The voltages for the MMCI GPIO controlled voltage regulation differ
> >> depending on who you believe and where you pick the information up
> >> from. More recent internal code suggests that the true upper voltage
> >> from the shifter is actually v3.3, instead of the previously
> >> indicated v2.9. Let's mirror that change in the Device Tree file.
> 
> This is wrong. The value should be 2.9V nothing else!

Don't panic. I'm already on this. :)

> >> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > Yours,
> > Linus Walleij
> 
> Kind regards
> Ulf Hansson

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
