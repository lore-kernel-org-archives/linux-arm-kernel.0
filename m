From: olof@lixom.net (Olof Johansson)
Date: Fri, 3 Apr 2015 13:53:45 -0700
Subject: [PATCH 1/4] ARM: multi_v7_defconfig: Enable Tegra ACTMON support
In-Reply-To: <1427726418-3806-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1427726418-3806-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20150403205345.GG23023@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 30, 2015 at 04:40:13PM +0200, Tomeu Vizoso wrote:
> This brings the DevFreq framework in and builds the ACTMON driver that
> on Tegra124 will scale the external memory clock based on current load.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---

Thanks, applied 1-4. In the future you can squash into one commit if you want.

-Olof
