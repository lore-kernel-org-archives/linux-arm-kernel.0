From: robert.richter@caviumnetworks.com (Robert Richter)
Date: Tue, 12 May 2015 18:42:49 +0200
Subject: [PATCH v4 00/11] drivers: PL011: add ARM SBSA Generic UART support
In-Reply-To: <1431440095-5146-1-git-send-email-andre.przywara@arm.com>
References: <1431440095-5146-1-git-send-email-andre.przywara@arm.com>
Message-ID: <20150512164249.GA20609@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.05.15 15:14:44, Andre Przywara wrote:
> This is the fourth revision of the SBSA UART support series, now
> based on the current tty-next branch.
> Compared to v3 I addressed some comments Jakub had on v3 (thanks for
> the review!). Also since some basic ACPI support for ARM64 is now
> upstream, I include the necessary ACPI binding as a new patch 11
> on top.
> ----

> Andre Przywara (10):
>   drivers: PL011: avoid potential unregister_driver call
>   drivers: PL011: refactor pl011_startup()
>   drivers: PL011: refactor pl011_shutdown()
>   drivers: PL011: refactor pl011_set_termios()
>   drivers: PL011: refactor pl011_probe()
>   drivers: PL011: replace UART_MIS reading with _RIS & _IMSC
>   drivers: PL011: move cts_event workaround into separate function
>   drivers: PL011: allow avoiding UART enabling/disabling
>   drivers: PL011: allow to supply fixed option string
>   drivers: PL011: add support for the ARM SBSA generic UART
> 
> Graeme Gregory (1):
>   drivers: PL011: add ACPI probing for SBSA UART

Tested-by: Robert Richter <rrichter@cavium.com>

... with devicetree and ACPI.

-Robert
