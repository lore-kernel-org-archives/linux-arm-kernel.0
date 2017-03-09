From: peppe.cavallaro@st.com (Giuseppe CAVALLARO)
Date: Thu, 9 Mar 2017 15:56:31 +0100
Subject: stmmac still supporting spear600 ?
In-Reply-To: <20170309103236.3e16304f@free-electrons.com>
References: <20170309093412.33c0277d@free-electrons.com>
 <373e2760-94c5-4349-33aa-158bc8f4b19e@st.com>
 <20170309103236.3e16304f@free-electrons.com>
Message-ID: <79049eda-5d37-6b70-8945-2d3ab55e56b8@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Thomas

On 3/9/2017 10:32 AM, Thomas Petazzoni wrote:

> OK, I'll have a look. However, I'm still confused by this DMA_RESET bit
> that never clears, contrary to what the datasheet says. Are there some
> erratas?

I suggest you to take a look at the tx/rx clocks from PHY.
You have to provide these otherwise you cannot reset the engine.

Best Regards
Peppe

>
> Best regards,
>
> Thomas
>
