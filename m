From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 6 Apr 2015 18:09:30 +0200
Subject: [PATCH v3 4/5] i2c: davinci: use bus recovery infrastructure
In-Reply-To: <55228613.2060607@linaro.org>
References: <1417448047-15236-1-git-send-email-grygorii.strashko@ti.com>
 <1417448047-15236-5-git-send-email-grygorii.strashko@ti.com>
 <20150318203151.GA12072@katana> <550C67D6.3080909@linaro.org>
 <20150403201846.GH2016@katana> <55228613.2060607@linaro.org>
Message-ID: <20150406160930.GA937@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >> Of course,  i2c_davinci_wait_bus_not_busy() has to be fixed first
> >> as proposed by Alexander Sverdlin here:
> >>   https://patchwork.ozlabs.org/patch/448994/.
> > 
> > Okay, good that you said it. So I'll give his patch series priority over
> > this one.
> 
> 
> Sorry, but this series already mises few merge windows and it has a lot
> of revied-by and tested-by, so could we proceed please?
> 
> Re-based & re-sent http://www.spinics.net/lists/arm-kernel/msg410810.html

??? Didn't you say above that Alexaders's patch is needed first?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150406/06916040/attachment.sig>
