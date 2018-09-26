From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 26 Sep 2018 17:41:56 +0800
Subject: [PATCH 1/2] ARM: dts: imx51-zii-rdu1: Fix the rtc compatible
 string
In-Reply-To: <1537271012-5159-1-git-send-email-festevam@gmail.com>
References: <1537271012-5159-1-git-send-email-festevam@gmail.com>
Message-ID: <20180926094154.GF26692@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2018 at 08:43:31AM -0300, Fabio Estevam wrote:
> According to Documentation/devicetree/bindings/rtc/rtc-ds1307.txt the
> original compatible "maxim,ds1341" is not a valid entry.
> 
> Switch to the documented "dallas,ds1341" compatible.
> 
> Reported-by: Chris Healy <cphealy@gmail.com>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied both, thanks.
