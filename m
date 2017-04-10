From: robh@kernel.org (Rob Herring)
Date: Mon, 10 Apr 2017 15:30:37 -0500
Subject: [PATCH v2 5/7] Documentation: dt: Add new compatible to STM32
 pinctrl driver bindings
In-Reply-To: <1491568984-20169-6-git-send-email-alexandre.torgue@st.com>
References: <1491568984-20169-1-git-send-email-alexandre.torgue@st.com>
 <1491568984-20169-6-git-send-email-alexandre.torgue@st.com>
Message-ID: <20170410203037.tpaejzcrjtb5lkay@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 07, 2017 at 02:43:02PM +0200, Alexandre TORGUE wrote:
> Add new compatible for stm32f469 MCU.

Again, the subject is a bit generic. Something like:

dt-bindings: pinctrl: Add st,stm32f469-pinctrl compatible to stm32-pinctrl

And this should come before the driver changes. 

With that,

Acked-by: Rob Herring <robh@kernel.org> 
