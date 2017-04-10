From: robh@kernel.org (Rob Herring)
Date: Mon, 10 Apr 2017 15:20:54 -0500
Subject: [PATCH v2 2/7] Documentation: dt: Remove bindings for STM32
 pinctrl
In-Reply-To: <1491568984-20169-3-git-send-email-alexandre.torgue@st.com>
References: <1491568984-20169-1-git-send-email-alexandre.torgue@st.com>
 <1491568984-20169-3-git-send-email-alexandre.torgue@st.com>
Message-ID: <20170410202054.urednfofxyb5iyou@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 07, 2017 at 02:42:59PM +0200, Alexandre TORGUE wrote:
> Remove "ngpios" bindings definition as it is no more used in stm32 pinctrl
> driver.

I read the subject as "rm 
Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt". You can 
be more specific:

dt-bindings: pinctrl: remove ngpios from stm32-pinctrl binding

With that,

Acked-by: Rob Herring <robh@kernel.org> 
