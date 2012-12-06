From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 6 Dec 2012 08:52:57 +0100
Subject: [PATCH] pwm: i.MX: eliminate build warning
In-Reply-To: <1354721681-31843-1-git-send-email-LW@KARO-electronics.de>
References: <1354721681-31843-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <20121206075256.GB25316@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 05, 2012 at 04:34:41PM +0100, Lothar Wa?mann wrote:
> compiling the i.MX pwm driver produces the following warning:
> |drivers/pwm/pwm-imx.c: In function 'imx_pwm_probe':
> |drivers/pwm/pwm-imx.c:281:7: warning: assignment discards qualifiers from pointer target type
> 
> Apply a 'const' attribute to the affected variable declaration.
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121206/3963751c/attachment.sig>
