From: robh@kernel.org (Rob Herring)
Date: Mon, 26 Jun 2017 14:08:26 -0500
Subject: [PATCH 1/8] dt-bindings: spi: stm32: use SoC specific compatible
In-Reply-To: <1498222550-19092-2-git-send-email-amelie.delaunay@st.com>
References: <1498222550-19092-1-git-send-email-amelie.delaunay@st.com>
 <1498222550-19092-2-git-send-email-amelie.delaunay@st.com>
Message-ID: <20170626190826.bm464jxtbmcfmjpp@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 23, 2017 at 02:55:43PM +0200, Amelie Delaunay wrote:
> This patch replaces st,stm32-spi compatible with st,stm32h7-spi SoC
> specific compatible and updates the example accondingly.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-stm32.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
