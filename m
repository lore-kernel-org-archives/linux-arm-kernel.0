From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 9 Mar 2017 10:32:36 +0100
Subject: stmmac still supporting spear600 ?
In-Reply-To: <373e2760-94c5-4349-33aa-158bc8f4b19e@st.com>
References: <20170309093412.33c0277d@free-electrons.com>
 <373e2760-94c5-4349-33aa-158bc8f4b19e@st.com>
Message-ID: <20170309103236.3e16304f@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Giuseppe,

Thanks for your answer.

On Thu, 9 Mar 2017 10:09:02 +0100, Giuseppe CAVALLARO wrote:

> We do not test stmmac on this spear board since many years
> and I guess you have to provide parameters from the platform.

Ok, that's what I was afraid of :-/

> In fact, stmmac is recently tested with DT.

I'm also using the DT, so this is definitely not the problem.

> IIRC, the mac on spear600 could not have the HW cap register

Correct.

> so it is mandatory to provide all the right parameters and
> configurations for this HW.

OK, I'll have a look. However, I'm still confused by this DMA_RESET bit
that never clears, contrary to what the datasheet says. Are there some
erratas?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
