From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 17 Oct 2011 17:44:00 -0200
Subject: [PATCH] imx: add polled io uart methods
In-Reply-To: <1318821721-11965-2-git-send-email-compnerd@compnerd.org>
References: <CAOMZO5CdVqCu8VvaYmxhDW-anG2NQt8Hn3CnM_a48g9V0q9bmA@mail.gmail.com>
	<1318821721-11965-1-git-send-email-compnerd@compnerd.org>
	<1318821721-11965-2-git-send-email-compnerd@compnerd.org>
Message-ID: <CAOMZO5AqjSV+n3=oTP4Ji57f_bVS8LgJDQxb37RbBF741iG9ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2011 at 1:22 AM, Saleem Abdulrasool
<compnerd@compnerd.org> wrote:
> These methods are invoked if the iMX uart is used in conjuction with kgdb during
> early boot. ?In order to access the UART without the interrupts, the kernel uses
> the basic polling methods for IO with the device. ?With these methods
> implemented, it is now possible to enable kgdb during early boot over serial.
>
> Signed-off-by: Saleem Abdulrasool <compnerd@compnerd.org>
> ---
> ?drivers/tty/serial/imx.c | ? 77 ++++++++++++++++++++++++++++++++++++++++++++++
> ?1 files changed, 77 insertions(+), 0 deletions(-)

You should run ./scripts/getmaintainer.pl to see what are the other
lists/maintainers you should also copy.

Regards,

Fabio Estevam
