From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 21 Jan 2013 14:02:41 +0000
Subject: [PATCH 1/1] ARM: ux500: Disable Power Supply and Battery
 Management by default
In-Reply-To: <CACRpkdYydqJ+BVsh7P411zCod+83f2pVV5tPsKfoWPYUnOVpDQ@mail.gmail.com>
References: <1358175470-5041-1-git-send-email-lee.jones@linaro.org>
 <CACRpkdYydqJ+BVsh7P411zCod+83f2pVV5tPsKfoWPYUnOVpDQ@mail.gmail.com>
Message-ID: <20130121140241.GA6857@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > The AB8500 Battery Management collection of drivers are more than a
> > little bit broken. There is lots of work still on-going in that area
> > and it's improving day by day; however, it's not ready to be enabled
> > by default just yet.
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Is this going for fixes (v3.8?)
> 
> For v3.9 I think you've submitted a whole lot of patches
> actually fixing it up?

I did submit a bunch of fixes, but more are required.

> Anyway: Acked-by: Linus Walleij <linus.walleij@linaro.org>
> since you certainly know the status of this driver better than
> me.

Thanks.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
