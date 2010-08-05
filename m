From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 5 Aug 2010 09:20:30 +0200
Subject: [PATCH 1/2] amba_pl022: Fix driver clock enable/disable balance
	issues
In-Reply-To: <1280851439-25468-2-git-send-email-wellsk40@gmail.com>
References: <1280851439-25468-1-git-send-email-wellsk40@gmail.com>
	<1280851439-25468-2-git-send-email-wellsk40@gmail.com>
Message-ID: <AANLkTikvMLRfd175-1YUbsgDRm68N65YZH3DborqHcLY@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/8/3  <wellsk40@gmail.com>:

> The pl022 clock enable and disable calls can become unbalanced. This
> code prevents clk_disable() from being called until clk_enable()
> has been called first.

This is not for the PL022. It's for the CLCD (Is that PL220?)
Same with the other patch...

Yours,
Linus Walleij
