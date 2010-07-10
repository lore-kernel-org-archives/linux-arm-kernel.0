From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sat, 10 Jul 2010 17:36:54 +0200
Subject: [PATCH v4] GPIO PL061: Adding Clk framework support
In-Reply-To: <20100710071913.GM22845@n2100.arm.linux.org.uk>
References: <1277183247-4557-1-git-send-email-viresh.kumar@st.com>
	<20100709124050.GF22845@n2100.arm.linux.org.uk>
	<AANLkTikm-wupuQA1_zsmqf3jrpavkMaw8Bt-GWb04TSo@mail.gmail.com>
	<20100710071913.GM22845@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimskXW4Nnxhc5bxwKiNrfJkMb-9NeWKhVOGaA1k@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/10 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> Correct, which is what drivers currently expect. ?This is also why
> two additional amba_* callbacks are supplied - if it is appropriate
> for a driver to disable their bus clock after being probed, they can
> do that but they have to participate in that.

Aha I get it, then it looks good...

Yours,
Linus Walleij
