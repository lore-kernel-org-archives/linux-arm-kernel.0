From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 22 Nov 2012 22:29:41 +0100
Subject: [PATCH v3] pwm: Device tree support for PWM polarity.
In-Reply-To: <1353483644-32711-1-git-send-email-avinashphilip@ti.com>
References: <1353483644-32711-1-git-send-email-avinashphilip@ti.com>
Message-ID: <20121122212941.GL16716@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 01:10:44PM +0530, Philip, Avinash wrote:
> Add support for encoding PWM properties in bit encoded form with
> of_pwm_xlate_with_flags() function support. Platforms require platform
> specific PWM properties has to populate in 3rd cell of the pwm-specifier
> and PWM driver should also set .of_xlate support with this function.
> Currently PWM property polarity encoded in bit position 0 of the third
> cell in pwm-specifier.
> 
> Signed-off-by: Philip, Avinash <avinashphilip@ti.com>

Applied with two minor stylistic cleanups, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121122/85d51df2/attachment-0001.sig>
