From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 8 Jan 2013 09:41:34 +0000
Subject: [PATCH] mfd: stmpe: Pull IRQ GPIO number from DT during DT-based
 probe
In-Reply-To: <50EB97E3.8050703@st.com>
References: <1357568989-16237-1-git-send-email-marex@denx.de>
 <20130107150341.GT21994@gmail.com>
 <201301071613.33573.marex@denx.de>
 <CAKohpon_h2ehq5Cf-fVyne33y7iyXCD35FVV1yuhgoDDstEcFQ@mail.gmail.com>
 <50EB97E3.8050703@st.com>
Message-ID: <20130108094134.GA21994@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >Both can be killed. gpios as interrupt lines can be requested as:
> >
> >  interrupt-parent =<&gpio-controller>;
> >  interrupts =<25 0x1>;
> >
> >and probably the stmpe driver doesn't have to bother at all if
> >interrupt was over gpio or not.

> Yes, both can be killed and similarly we did for spear1340 machine
> but some how we missed it on spear320-hmi.

Bingo!

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
