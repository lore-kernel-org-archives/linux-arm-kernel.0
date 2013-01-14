From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 14 Jan 2013 08:37:04 +0800
Subject: [PATCH] ARM: imx: imxfb: fix imxfb_info configuration order
In-Reply-To: <1358092603-13480-2-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1358092603-13480-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
 <1358092603-13480-2-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <20130114003702.GA24575@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 13, 2013 at 04:56:43PM +0100, Gwenhael Goavec-Merou wrote:
> From: Gwenhael Goavec-Merou <gwe@trabucayre.com>
> 
> The devtype field for fbi (struct imxfb_info) must be set after memset call to
> avoid some wrong behaviour (pixel size).
> 
> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>

Gwenhael,

Thanks for fixing the problems left from patch e69dc9a (video: imxfb:
remove cpu_is_xxx by using platform_device_id).

Considering the absence of FB maintainer, I will send both patches
through arm-soc tree for -rc.  But since it's still a FB patch,
I changed the patch prefix to "video: imxfb: ...".

Shawn
