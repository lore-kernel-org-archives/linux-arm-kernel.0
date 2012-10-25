From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 25 Oct 2012 09:23:41 +0100
Subject: [PATCH 2/6] pinctrl: Update clock handling for the
 pinctrl-nomadik GPIO driver
In-Reply-To: <5088F0EE.8030900@stericsson.com>
References: <1351089926-32161-1-git-send-email-lee.jones@linaro.org>
 <1351089926-32161-3-git-send-email-lee.jones@linaro.org>
 <CACRpkdaeBW2ecQZ2fA-hL8o47pYpjZ=5Mn131F87u58rX+dekw@mail.gmail.com>
 <20121025073127.GB971@gmail.com> <5088F0EE.8030900@stericsson.com>
Message-ID: <20121025082341.GC3348@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Oct 2012, Linus Walleij wrote:

> On 10/25/2012 09:31 AM, Lee Jones wrote:
> >
> >This certainly doesn't fix the bug we spoke about. I believe Ulf
> >is still working on that one.
> >
> >So do you want me to remove this patch?
> >
> 
> Yeah drop it for now.

Actually, a quick question before I do:

If it's better/faster to prepare the clock and keep it prepared
while you do clk_enable/clk_disable, why don't we do that in all
drivers? Why do we bother to prepare/unprepare each time if all
it does is take up cycles?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
