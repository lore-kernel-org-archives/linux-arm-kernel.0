From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 4 Dec 2012 09:12:15 +0000
Subject: [PATCH 1/1] ARM: ux500: Change IRQ from low-to-high edge
 triggered to high-to-low
In-Reply-To: <CACRpkdafvpnyq7YMV=iSjN4+u1hpt3xntAb-daJZifG9VpgnOw@mail.gmail.com>
References: <1354289099-17931-1-git-send-email-lee.jones@linaro.org>
 <CACRpkdafvpnyq7YMV=iSjN4+u1hpt3xntAb-daJZifG9VpgnOw@mail.gmail.com>
Message-ID: <20121204091215.GD2718@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 01 Dec 2012, Linus Walleij wrote:

> On Fri, Nov 30, 2012 at 4:24 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > When the STMPE IRQ is triggered to be active high level-sensitive, the
> > Nomadik GPIO controller it uses complains, although it still works.
> > Recently we attempted to move triggering to low-to-high in an attempt
> > to prevent the warning; however, this ensured that the IRQ was actually
> > missed completely. Now we have a solution which both works and keeps the
> > GPIO controller happy.
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Is this something I should put into the ux500 tree or will you
> take care of this in a separate pull request?

Can you still get this into the RCs, as it's a bugfix?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
