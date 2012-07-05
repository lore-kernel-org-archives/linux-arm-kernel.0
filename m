From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 5 Jul 2012 13:51:02 +0000
Subject: [PATCH 3/9] ARM: ux500: Remove AB8500 regulator register
 initialisation information
In-Reply-To: <1341493572-29735-4-git-send-email-lee.jones@linaro.org>
References: <1341493572-29735-1-git-send-email-lee.jones@linaro.org>
 <1341493572-29735-4-git-send-email-lee.jones@linaro.org>
Message-ID: <201207051351.03115.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 July 2012, Lee Jones wrote:
> There is no need to initialise the AB8500's regulator registers, as
> most of this work is already carried out by framework features, so
> we can safely remove all traces from platform code.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

It makes sense, but this patch is basically a revert of dfa3a824d
"mach-ux500: provide ab8500 init vector" from Bengt Jonsson, so
it would be nice to get an Ack from him.

	Arnd
