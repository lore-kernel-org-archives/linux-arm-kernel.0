From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Tue, 01 Mar 2011 20:59:14 +0000
Subject: [PATCH v2 2/4] ASoC: Fix burstsize and DSP_B format problems
	in imx-ssi.
In-Reply-To: <1298988128-11520-3-git-send-email-javier.martin@vista-silicon.com>
References: <1298988128-11520-1-git-send-email-javier.martin@vista-silicon.com>
	<1298988128-11520-3-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <1299013154.3345.84.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-03-01 at 15:02 +0100, Javier Martin wrote:
> When choosing IMX_DMA flag, burtsizes are set to its default
> value (0) which leads to driver malfunction. Change them to 4.
> 
> DSP_B interface needs additional flag to match DSP_B formats
> as described in several codecs as wm8741 and aic3205.
> 
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>

Please CC both Mark and I on all ASoC patches otherwise I may not see
them.

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
