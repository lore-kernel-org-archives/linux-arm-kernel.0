From: robh@kernel.org (Rob Herring)
Date: Wed, 28 Jun 2017 13:06:03 -0500
Subject: [PATCH 02/20] dt-bindings: serial: each stm32 usart needs an alias
In-Reply-To: <1498481318-1894-3-git-send-email-bich.hemon@st.com>
References: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
 <1498481318-1894-3-git-send-email-bich.hemon@st.com>
Message-ID: <20170628180603.4w5acuv4j2lylnv3@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 26, 2017 at 12:49:09PM +0000, Bich HEMON wrote:
> From: Bich Hemon <bich.hemon@st.com>
> 
> Each usart controller should have an alias correctly
> numbered in "aliases" node.

This is board specific typically and doesn't need to be in the binding 
doc.

Rob
