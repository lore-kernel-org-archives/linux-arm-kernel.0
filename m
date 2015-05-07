From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 7 May 2015 16:13:58 +0100
Subject: [PATCH v3 3/6] usb: dwc3: dwc3-st: Update the incorrect DT dwc3
 example.
In-Reply-To: <1430400652-3366-4-git-send-email-peter.griffin@linaro.org>
References: <1430400652-3366-1-git-send-email-peter.griffin@linaro.org>
 <1430400652-3366-4-git-send-email-peter.griffin@linaro.org>
Message-ID: <20150507151358.GA14123@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

On Thu, 30 Apr 2015, Peter Griffin wrote:

> There is a subtle typo phys-names should be phy-names. Using the
> current example means you don't have working usb (as you fail to
> obtain the phys). Also update the example to use the generic phy
> type constants which are now used for miphy28.
> 
> Additionally also remove the unnecessary new line in the example.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Can you take this dwc3 DT doc update patch via your tree?

regards,

Peter.
