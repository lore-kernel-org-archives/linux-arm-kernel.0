From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Sun, 30 May 2010 12:42:28 +0900
Subject: [PATCH v2 5/5] input: samsung-keypad - Add samsung keypad driver
In-Reply-To: <1275188784-23395-5-git-send-email-jy0922.shim@samsung.com>
References: <1275188784-23395-1-git-send-email-jy0922.shim@samsung.com>
	<1275188784-23395-5-git-send-email-jy0922.shim@samsung.com>
Message-ID: <4C01DEA4.1080704@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/30/2010 12:06 PM, Joonyoung Shim wrote:
> This patch adds support for keypad driver running on Samsung cpus. This
> driver is tested on GONI and Aquila board using S5PC110 cpu.
> 
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/input/keyboard/Kconfig          |    9 +
>  drivers/input/keyboard/Makefile         |    1 +
>  drivers/input/keyboard/samsung-keypad.c |  364 +++++++++++++++++++++++++++++++
>  3 files changed, 374 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/keyboard/samsung-keypad.c
> 

Sorry for bothering.
Please use following patch because of typo of prior patch.
