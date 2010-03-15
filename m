From: jassisinghbrar@gmail.com (jassi brar)
Date: Mon, 15 Mar 2010 16:00:03 +0900
Subject: QUERY: How to handle sharing of interrupt between different
	peripherals.
In-Reply-To: <4B9DD9F0.60603@st.com>
References: <4B9DB99A.5040104@st.com>
	<1b68c6791003142218q24fd8516id75d6964201da3f2@mail.gmail.com>
	<4B9DD766.7010504@st.com>
	<1b68c6791003142350t1a671bf0k4777d8d4df8c5ab7@mail.gmail.com>
	<4B9DD9F0.60603@st.com>
Message-ID: <1b68c6791003150000s4417e982ofa7dc2998575bd67@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 15, 2010 at 3:55 PM, Viresh KUMAR <viresh.kumar@st.com> wrote:
> Second: Now UART, SDIO, SPI, I2S all have a common interrupt line, this is what
> we need to handle. For this IRQF_SHARED is a better way.
ok, I misunderstood.
