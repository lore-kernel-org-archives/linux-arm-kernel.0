From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 15 May 2018 15:10:23 +0800
Subject: [PATCH] ARM: dts: vf-colibri-eval-v3.dtsi: Use IRQ_TYPE specifier
In-Reply-To: <1526253894-3709-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1526253894-3709-1-git-send-email-hernan@vanguardiasur.com.ar>
Message-ID: <20180515071021.GL26863@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 13, 2018 at 08:24:54PM -0300, Hern?n Gonzalez wrote:
> GPIO_ACTIVE_LOW was being used to specify an interrupt, use
> IRQ_TYPE_EDGE_RISING instead. This improves DT readability.
> 
> Signed-off-by: Hern?n Gonzalez <hernan@vanguardiasur.com.ar>

Applied, thanks.
