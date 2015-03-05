From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 5 Mar 2015 16:44:20 +0100
Subject: [PATCH] clocksource: sun5i: Refactor the current code
In-Reply-To: <1425565972-30316-1-git-send-email-daniel.lezcano@linaro.org>
References: <54F86883.7080208@linaro.org>
 <1425565972-30316-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20150305154420.GX4911@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 05, 2015 at 03:32:52PM +0100, Daniel Lezcano wrote:
> From: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Refactor the code in order to remove the global variables and split the clock
> source and clock events registration in order to ease the addition of the clock
> notifiers needed to handle the parent clock rate changes.
> 
> [dlezcano] : Fixed conflict with commit 1096be084ac59927158ce80ff1d31c33eed0e565
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

It looks good, thanks for taking care of this!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150305/41c6d9f9/attachment.sig>
