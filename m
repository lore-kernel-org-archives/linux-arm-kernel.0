From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 26 Jan 2016 15:54:16 -0800
Subject: [PATCH V3] ARM: BCM5301X: Add DT for D-Link DIR-885L
In-Reply-To: <1453847716-9406-1-git-send-email-zajec5@gmail.com>
References: <1453845752-8174-1-git-send-email-zajec5@gmail.com>
 <1453847716-9406-1-git-send-email-zajec5@gmail.com>
Message-ID: <56A80728.4010102@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/01/16 14:35, Rafa? Mi?ecki wrote:
> It's device based on BCM47094 which is quite similar to BCM4709 except
> for higher CPU frequency. This device has 2 flash memories, it boots
> from serial one and stores firmware on NAND. Other than that we define
> standard stuff like LEDs, buttons and UART.
> 
> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>

Applied to devicetree/next, thanks!
-- 
Florian
