From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 26 Jan 2013 15:25:33 +0800
Subject: [PATCH] Asoc: Samsung: Add I2S S/W RST in startup function
In-Reply-To: <1359030931-27354-2-git-send-email-rcsekar@samsung.com>
References: <1359030931-27354-1-git-send-email-rcsekar@samsung.com>
 <1359030931-27354-2-git-send-email-rcsekar@samsung.com>
Message-ID: <20130126072531.GM10580@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 24, 2013 at 06:05:31PM +0530, R. Chandrasekar wrote:
> From: Padmavathi Venna <padma.v@samsung.com>
> 
> I2S module need to be reset after S2R. Keeping the S/W rst
> control part in resume didn't help in playing audio after resume.
> So this patch adds S/W RST control part in startup function which
> gets triggered for every new audio stream playback.

Applied, thanks.  Please use subject lines matching the subsystem.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130126/dcf6e4df/attachment.sig>
