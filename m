From: olof@lixom.net (Olof Johansson)
Date: Mon, 22 Jul 2013 19:35:52 -0700
Subject: [PATCH v2 1/2] ARM: dts: STi: Fix pinconf setup for STiH416
 serial2
In-Reply-To: <1373354784-26357-1-git-send-email-srinivas.kandagatla@st.com>
References: <1373354752-26292-1-git-send-email-srinivas.kandagatla@st.com>
 <1373354784-26357-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <20130723023552.GB14983@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 09, 2013 at 08:26:24AM +0100, Srinivas KANDAGATLA wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> 
> This patch fixes a bug in pinctrl setup of serial2 device, Some of the
> pins in the pinctrl node of serial2 do not belong to that
> pin-controller. This patch divides them in the pins into there
> respective pin controller nodes.
> 
> Without this patch serial on StiH416-B2000 Board will not work as it
> fails with:
> 
> "st-pinctrl pin-controller-rear.3: failed to get pin(99) name
> st-pinctrl pin-controller-rear.3: maps: function serial2 group serial2-0
> num 4
> pinconfig core: failed to register map default (3): no group/pin given"
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>

Applied to fixes, thanks.


-Olof
