From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 17 May 2012 13:28:02 +0100
Subject: [PATCH 1/2] ARM: s3c64xx: cpuidle - declare the states with the
 new api
In-Reply-To: <1337004377-17732-2-git-send-email-daniel.lezcano@linaro.org>
References: <1337004377-17732-1-git-send-email-daniel.lezcano@linaro.org>
 <1337004377-17732-2-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20120517122802.GG26337@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2012 at 04:06:16PM +0200, Daniel Lezcano wrote:
> The states are now part of the cpuidle_driver structure, so we can
> declare the states in this structure directly. That saves us an extra
> variable declaration and a memcpy.

Tested-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120517/5806f7b3/attachment.sig>
