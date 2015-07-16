From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 16 Jul 2015 13:47:41 +0200
Subject: [PATCH 1/2] ASoC: rockchip: Add machine driver for max98090 codec
In-Reply-To: <20150716110032.GU11162@sirena.org.uk>
References: <1436930143-31361-1-git-send-email-zhengxing@rock-chips.com>
 <1436930143-31361-2-git-send-email-zhengxing@rock-chips.com>
 <1437033944.27428.11.camel@tiscali.nl>
 <20150716110032.GU11162@sirena.org.uk>
Message-ID: <1437047261.28351.6.camel@tiscali.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On do, 2015-07-16 at 12:00 +0100, Mark Brown wrote:
> You've got platform_device and platform_driver confused I think.

I did? You mean that creating a platform_DRIVER triggers that
MODALIAS=platform:{...] uevent?


Paul Bolle
