From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 26 Mar 2015 22:46:31 +0100
Subject: [PATCH 02/13] tty: serial: atmel: fix big-endian on ARMv7 devices
In-Reply-To: <1426693992-31163-3-git-send-email-ben.dooks@codethink.co.uk>
References: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
 <1426693992-31163-3-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20150326214631.GA15051@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 03:53:01PM +0000, Ben Dooks wrote:
> Add support for using this driver on ARMv7 devices configured for
> big endian.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> --
> CC: Nicolas Ferre <nicolas.ferre@atmel.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Jiri Slaby <jslaby@suse.cz>
> CC: linux-serial at vger.kernel.org
> CC: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
> ---
>  drivers/tty/serial/atmel_serial.c | 62 ++++++++++++++++++++++-----------------
>  1 file changed, 35 insertions(+), 27 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
