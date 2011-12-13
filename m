From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 13 Dec 2011 14:40:48 +0800
Subject: [PATCH 06/19] mx27vis-aic32x4: only register when running on the
 right machine
In-Reply-To: <1323757911-25217-6-git-send-email-eric@eukrea.com>
References: <1323757911-25217-1-git-send-email-eric@eukrea.com>
 <1323757911-25217-6-git-send-email-eric@eukrea.com>
Message-ID: <20111213064047.GD7148@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2011 at 07:31:38AM +0100, Eric B?nard wrote:
> without this fix, a kernel compiled with imx_v4_v5_defconfig
> and running on a cpuimx25sd leads to :

I'll apply this but a better fix is to convert the driver to be a normal
platform driver and only register the device on the appropraite boards.
