From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Jul 2011 18:47:46 +0200
Subject: [PATCH 2/3] mach-ux500: export System-on-Chip information via
	sysfs
In-Reply-To: <1310476090-9807-2-git-send-email-lee.jones@linaro.org>
References: <1310476090-9807-1-git-send-email-lee.jones@linaro.org>
	<1310476090-9807-2-git-send-email-lee.jones@linaro.org>
Message-ID: <201107121847.46144.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 July 2011, Lee Jones wrote:
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Just like last time:

   NAK

You still have all the SoC devices as top-level platform devices.
Make them children of the SoC device you create here, and we can
apply this patch.

	Arnd
