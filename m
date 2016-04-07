From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 7 Apr 2016 07:43:11 -0700
Subject: [PATCH v5 04/10] serial: mps2-uart: add MPS2 UART driver
In-Reply-To: <57065ABA.4080506@arm.com>
References: <1459519381-34441-1-git-send-email-vladimir.murzin@arm.com>
 <1459519381-34441-5-git-send-email-vladimir.murzin@arm.com>
 <57065ABA.4080506@arm.com>
Message-ID: <20160407144311.GC10853@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 07, 2016 at 02:03:54PM +0100, Vladimir Murzin wrote:
> On 01/04/16 15:02, Vladimir Murzin wrote:
> > This driver adds support to the UART controller found on ARM MPS2
> > platform.
> > 
> > Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> > ---
> >  drivers/tty/serial/Kconfig       |   12 +
> >  drivers/tty/serial/Makefile      |    1 +
> >  drivers/tty/serial/mps2-uart.c   |  598 ++++++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/serial_core.h |    3 +
> >  4 files changed, 614 insertions(+)
> >  create mode 100644 drivers/tty/serial/mps2-uart.c
> 
> Greg, any comments from you?

No idea, first I've seen of this, and there's no patch here...
