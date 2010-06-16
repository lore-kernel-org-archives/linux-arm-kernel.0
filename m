From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Wed, 16 Jun 2010 17:17:32 +0900
Subject: [PATCH v4 3/3] input: samsung-keypad - Add samsung keypad driver
In-Reply-To: <1276243728-17704-3-git-send-email-jy0922.shim@samsung.com>
References: <1276243728-17704-1-git-send-email-jy0922.shim@samsung.com>
	<1276243728-17704-3-git-send-email-jy0922.shim@samsung.com>
Message-ID: <4C18889C.2030501@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/11/2010 5:08 PM, Joonyoung Shim wrote:
> This patch adds support for keypad driver running on Samsung cpus. This
> driver is tested on GONI and Aquila board using S5PC110 cpu.
> 
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/input/keyboard/Kconfig          |    9 +
>  drivers/input/keyboard/Makefile         |    1 +
>  drivers/input/keyboard/samsung-keypad.c |  400 +++++++++++++++++++++++++++++++
>  3 files changed, 410 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/keyboard/samsung-keypad.c
> 

Hi,

Dmitry and Kukjin, any feedback on this?
