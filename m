From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 14 Mar 2015 22:26:26 +0100
Subject: [PATCH 06/10] ARM: zx: add cpu hotplug support
In-Reply-To: <1426333785-3952-7-git-send-email-jun.nie@linaro.org>
References: <1426333785-3952-1-git-send-email-jun.nie@linaro.org>
 <1426333785-3952-7-git-send-email-jun.nie@linaro.org>
Message-ID: <2481948.uciyoZLuZn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 14 March 2015 19:49:41 Jun Nie wrote:
> It's a clone of vexpress cpu hotplug implementation.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> 

Please explain exactly why you cannot use a proper CPU poweroff
function here. Nobody should copy that code from vexpress for a
real system.

	Arnd
