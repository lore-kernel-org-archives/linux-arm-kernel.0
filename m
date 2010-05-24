From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Mon, 24 May 2010 23:51:11 +0200
Subject: Should we pass amba device peripheral id with device structure or
	not?
In-Reply-To: <4BFA02DC.6090906@st.com>
References: <4BECF57A.4050802@st.com>
	<20100521193802.GG11042@n2100.arm.linux.org.uk>
	<4BFA02DC.6090906@st.com>
Message-ID: <AANLkTill9wh_8PqLAoWEpQtKhV-7Yc0zWs870EVJLtBb@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Viresh]

2010/5/24 Viresh KUMAR <viresh.kumar@st.com>:

> There is only one bit per peripheral to enable/disable clock.
> So with clocks disabled, we get 0x00000000 on read from device registers.

You're lucky to get zero, I get an AHB bus error and everything
locks up.

Yours,
Linus Walleij
