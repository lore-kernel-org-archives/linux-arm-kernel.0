From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 7 Apr 2016 14:03:54 +0100
Subject: [PATCH v5 04/10] serial: mps2-uart: add MPS2 UART driver
In-Reply-To: <1459519381-34441-5-git-send-email-vladimir.murzin@arm.com>
References: <1459519381-34441-1-git-send-email-vladimir.murzin@arm.com>
 <1459519381-34441-5-git-send-email-vladimir.murzin@arm.com>
Message-ID: <57065ABA.4080506@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/16 15:02, Vladimir Murzin wrote:
> This driver adds support to the UART controller found on ARM MPS2
> platform.
> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  drivers/tty/serial/Kconfig       |   12 +
>  drivers/tty/serial/Makefile      |    1 +
>  drivers/tty/serial/mps2-uart.c   |  598 ++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/serial_core.h |    3 +
>  4 files changed, 614 insertions(+)
>  create mode 100644 drivers/tty/serial/mps2-uart.c

Greg, any comments from you?

Cheers
Vladimir
