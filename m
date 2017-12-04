From: robh@kernel.org (Rob Herring)
Date: Mon, 4 Dec 2017 15:51:12 -0600
Subject: [PATCH v6 12/13] ASoC: add bindings for stm32 DFSDM filter
In-Reply-To: <1512150020-20335-13-git-send-email-arnaud.pouliquen@st.com>
References: <1512150020-20335-1-git-send-email-arnaud.pouliquen@st.com>
 <1512150020-20335-13-git-send-email-arnaud.pouliquen@st.com>
Message-ID: <20171204215112.upkujy6grec6urae@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 01, 2017 at 06:40:19PM +0100, Arnaud Pouliquen wrote:
> Add bindings that describes audio settings to support
> Digital Filter for pulse density modulation(PDM) microphone.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
>  .../devicetree/bindings/sound/st,stm32-adfsdm.txt  | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt

Acked-by: Rob Herring <robh@kernel.org>
