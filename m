From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 12 Mar 2011 10:38:01 +0100
Subject: [PATCH 10/10] ux500: adding config file options for snowball
	board.
In-Reply-To: <1299884892-6766-11-git-send-email-mathieu.poirier@linaro.org>
References: <1299884892-6766-1-git-send-email-mathieu.poirier@linaro.org>
	<1299884892-6766-11-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <201103121038.01364.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 12 March 2011 00:08:12 mathieu.poirier at linaro.org wrote:
> From: Mathieu J. Poirier <mathieu.poirier@linaro.org>
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  arch/arm/configs/u8500_defconfig | 1497 ++++++++++++++++++++++++++++++++++++++
>  1 files changed, 1497 insertions(+), 0 deletions(-)

Hi Mathieu,

Please use "make savedefconfig" to create a minimal form of this
file, instead of the full .config.

	Arnd
