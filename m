From: broonie@kernel.org (Mark Brown)
Date: Sat, 21 Dec 2013 14:29:59 +0000
Subject: [PATCH 00/10] ASoC: ARM: ux500: Better prepare for full Device
 Tree
In-Reply-To: <1387468508-12286-1-git-send-email-lee.jones@linaro.org>
References: <1387468508-12286-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20131221142959.GH30815@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 03:54:57PM +0000, Lee Jones wrote:
> At this moment in time the Ux500 ASoC driver obtains its DMA information
> via AUXDATA platform data passing. To make the driver more independent
> we have to start extracting it from the Device Tree. This patch-set goes
> some way to ensure the ux500 Audio driver is ready for the switch over.

This all looks good to me, I guess it's OK if I merge the ARM patch?
