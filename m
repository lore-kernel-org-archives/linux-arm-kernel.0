From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 28 Nov 2013 16:58:28 +0100
Subject: [PATCH 3/3] ARM: imx_v6_v7_defconfig: Enable mc13xxx-pwm support.
In-Reply-To: <1385566771-366-3-git-send-email-denis@eukrea.com>
References: <1385566771-366-1-git-send-email-denis@eukrea.com>
 <1385566771-366-3-git-send-email-denis@eukrea.com>
Message-ID: <20131128155827.GD23201@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 27, 2013 at 04:39:31PM +0100, Denis Carikli wrote:
> The eukrea mbimx53sd has its display backlighgt
>   connected to the pwm of its mc13xxx, so we turn
>   it on.

This is weirdly formatted. Also check the spelling: "backlighgt" ->
"backlight", "pwm" -> "PWM", "eukrea" -> "Eukrea".

Also, perhaps: ", so we enable the PWM driver."

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131128/61b964d4/attachment.sig>
