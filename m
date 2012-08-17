From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 17 Aug 2012 08:32:11 +0800
Subject: [PATCH v4 2/3] Input: add devicetree binding note for egalax_ts
In-Reply-To: <1345114051-3052-3-git-send-email-jason77.wang@gmail.com>
References: <1345114051-3052-1-git-send-email-jason77.wang@gmail.com>
 <1345114051-3052-2-git-send-email-jason77.wang@gmail.com>
 <1345114051-3052-3-git-send-email-jason77.wang@gmail.com>
Message-ID: <20120817003209.GB24242@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2012 at 06:47:30PM +0800, Hui Wang wrote:
> The egalax_ts driver needs to get the gpio number of the irq pin,
> and use this gpio to wake up the controller. So add a note
> for this change.
> 
> Signed-off-by: Hui Wang <jason77.wang@gmail.com>

Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
