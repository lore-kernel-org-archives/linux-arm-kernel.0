From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Feb 2018 00:09:33 -0600
Subject: [PATCH 02/14] dt-bindings: clock: add STM32MP1 clocks
In-Reply-To: <1517580222-23301-3-git-send-email-gabriel.fernandez@st.com>
References: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
 <1517580222-23301-3-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20180205042348.2f7ssmzkajeky5l7@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 02, 2018 at 03:03:30PM +0100, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This patch adds the clock binding entry for STM32MP1
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>  include/dt-bindings/clock/stm32mp1-clks.h | 248 ++++++++++++++++++++++++++++++
>  1 file changed, 248 insertions(+)
>  create mode 100644 include/dt-bindings/clock/stm32mp1-clks.h

You can squash this into the previous patch.
