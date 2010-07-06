From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Tue, 06 Jul 2010 16:58:18 +0900
Subject: [PATCH v6 3/3] input: samsung-keypad - Add samsung keypad driver
In-Reply-To: <1277724824-13308-3-git-send-email-jy0922.shim@samsung.com>
References: <1277724824-13308-1-git-send-email-jy0922.shim@samsung.com>
	<1277724824-13308-3-git-send-email-jy0922.shim@samsung.com>
Message-ID: <4C32E21A.8080100@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Naveen.

On 6/28/2010 8:33 PM, Joonyoung Shim wrote:
> This patch adds support for keypad driver running on Samsung cpus. This
> driver is tested on GONI and Aquila board using S5PC110 cpu.
> 
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/input/keyboard/Kconfig          |    9 +
>  drivers/input/keyboard/Makefile         |    1 +
>  drivers/input/keyboard/samsung-keypad.c |  491 +++++++++++++++++++++++++++++++
>  3 files changed, 501 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/keyboard/samsung-keypad.c
> 

Could you please test this v6 keypad driver on your various targets?
