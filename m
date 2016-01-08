From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 08 Jan 2016 13:53:29 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: Add rockchip audio support
In-Reply-To: <1452255406-2439-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1452255406-2439-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <4970673.6FENizv1M6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 January 2016 13:16:46 Sjoerd Simons wrote:
> As the rockchip SPDIF driver landed for 4.4 and the required clock
> patches to make it work properly are scheduled for the 4.5 merge window
> it seems time to support for audio device found on rockchip boards in
> the defconfig as well.
> 
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> 

Applied to next/defconfig with Heiko's Ack as discussed on IRC.

	Arnd
