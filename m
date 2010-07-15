From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 15 Jul 2010 11:44:42 +0200
Subject: [PATCH v4] GPIO PL061: Adding Clk framework support
In-Reply-To: <4C3ED678.7010308@st.com>
References: <1277183247-4557-1-git-send-email-viresh.kumar@st.com>
	<20100709124050.GF22845@n2100.arm.linux.org.uk>
	<AANLkTikm-wupuQA1_zsmqf3jrpavkMaw8Bt-GWb04TSo@mail.gmail.com>
	<20100710071913.GM22845@n2100.arm.linux.org.uk>
	<AANLkTimskXW4Nnxhc5bxwKiNrfJkMb-9NeWKhVOGaA1k@mail.gmail.com>
	<20100713074449.GA20118@n2100.arm.linux.org.uk>
	<AANLkTilZJTHh_iFS37UL7XoUs_DhAB50A3tHfcfEr5JM@mail.gmail.com>
	<20100713182644.GC30142@n2100.arm.linux.org.uk>
	<4C3EA46B.1000709@st.com>
	<20100715083032.GA26212@n2100.arm.linux.org.uk>
	<4C3ED678.7010308@st.com>
Message-ID: <AANLkTinlt5MRzArqZTWWD8ZptamgvGOvdYVY1NfUCWVv@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/15 Viresh KUMAR <viresh.kumar@st.com>:

> Just a little issue, in your patch you were enabling interface clock in
> amba_probe which is called after reading peripheral id registers in
> amba_device_register. We need interface clock enabled before reading these
> registers.

Rabin already noted this and Russell says he'll fix it before applying the
patch.

Yours,
Linus Walleij
