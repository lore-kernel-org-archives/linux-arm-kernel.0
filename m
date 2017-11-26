From: robh@kernel.org (Rob Herring)
Date: Sun, 26 Nov 2017 13:05:39 -0600
Subject: [PATCH 1/3] ASoC: stm32: fix sync property description in SAI
 bindings
In-Reply-To: <1511362947-14747-2-git-send-email-olivier.moysan@st.com>
References: <1511362947-14747-1-git-send-email-olivier.moysan@st.com>
 <1511362947-14747-2-git-send-email-olivier.moysan@st.com>
Message-ID: <20171126190539.ordmumh3vekfsqls@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 22, 2017 at 04:02:25PM +0100, Olivier Moysan wrote:
> SAI sync property must be described in SAI subnodes
> section, as it is a property of child node.
> This patch fixes commit 14f0e5f8d97e632695d92f41f2e91d10d8005d47
> "ASoC: stm32: Add synchronization to SAI bindings".
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> ---
>  Documentation/devicetree/bindings/sound/st,stm32-sai.txt | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
