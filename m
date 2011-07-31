From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 31 Jul 2011 02:09:33 +0200
Subject: [PATCH 08/18] dmaengine/amba-pl08x: No need to check "ch->signal
	< 0"
In-Reply-To: <1e1f287888a2ce9affdcbded8f63028fa3f6b09b.1311936524.git.viresh.kumar@st.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<1e1f287888a2ce9affdcbded8f63028fa3f6b09b.1311936524.git.viresh.kumar@st.com>
Message-ID: <CAKnu2MrtC9uqguPKFXYJnzys6hMMnMU9eBsGQ0DXkP67ZzOnVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/29 Viresh Kumar <viresh.kumar@st.com>:

> We have just executed following in pl08x_get_phy_channel():
> ? ? ? ?ch->signal = -1;
> We don't have to compare "ch->signal < 0", as this will always be true.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
