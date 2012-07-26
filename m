From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 26 Jul 2012 12:28:48 +0100
Subject: [PATCH 00/21] Some fixes and DT enablement for ux500 audio
In-Reply-To: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20120726112848.GX3099@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2012 at 11:28:33AM +0100, Lee Jones wrote:
> This patch-set sees some code reinforcement surrounding the recently
> accepted MOP500 MSP, PCM, AB8500 CODEC and ux500 Audio Machine Driver.
> It contains some extra error checking pertaining to the ux500 specific
> drivers themselves, along with bugfixes for issues in core SoC Audio 
> code happened upon along the way. There are also a couple of minor 
> clean-ups relating to ux500 platform code, which are hitching a ride 
> for ease of status tracking.

Please restructure this so that the actual error fixes (which should go
into 3.6) are before the random cleanups (which should go into 3.7)
rather than mixing them together.  It'd also be helpful if you could
split out changes to the different subsystems separately when there's no
overlap (which mostly looks to be the case here).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120726/39709216/attachment.sig>
