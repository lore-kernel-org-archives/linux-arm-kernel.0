From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 7 May 2014 11:43:05 -0300
Subject: [PATCH] clk: clk-divider: Fix infinite loop for table divider
In-Reply-To: <5369F0D6.3080503@st.com>
References: <1399408005-4209-1-git-send-email-festevam@gmail.com>
 <5369F0D6.3080503@st.com>
Message-ID: <CAOMZO5CoSJB1kqBMoE6_8WL_WektBC0RXWbk60wPi=tbYJK_Og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 7, 2014 at 5:37 AM, Maxime Coquelin <maxime.coquelin@st.com> wrote:

> Couldn't we initialize "up" variable to INT_MAX in _round_up_table() as I
> just proposed in mail thread reporting the regression?

Yes, it works fine. Please submit your version.

Thanks
