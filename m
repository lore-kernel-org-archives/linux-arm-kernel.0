From: robh@kernel.org (Rob Herring)
Date: Wed, 28 Jun 2017 13:04:52 -0500
Subject: [PATCH 1/2] dt-bindings: rtc: stm32: add support for STM32H7
In-Reply-To: <1498470689-26829-2-git-send-email-amelie.delaunay@st.com>
References: <1498470689-26829-1-git-send-email-amelie.delaunay@st.com>
 <1498470689-26829-2-git-send-email-amelie.delaunay@st.com>
Message-ID: <20170628180452.rdvnul7cifxglu7f@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 26, 2017 at 11:51:28AM +0200, Amelie Delaunay wrote:
> This patch documents support for STM32H7 Real Time Clock.
> It introduces a new compatible and rework clock definitions.
> On STM32H7 we have a 'pclk' clock for register access, in addition to
> the 'rtc_ck' clock.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  .../devicetree/bindings/rtc/st,stm32-rtc.txt       | 32 ++++++++++++++++++----
>  1 file changed, 27 insertions(+), 5 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
