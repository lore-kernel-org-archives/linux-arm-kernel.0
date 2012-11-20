From: tklauser@distanz.ch (Tobias Klauser)
Date: Tue, 20 Nov 2012 10:44:49 +0100
Subject: [PATCH 161/493] tty: remove use of __devinit
In-Reply-To: <1353349642-3677-161-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-161-git-send-email-wfp5p@virginia.edu>
Message-ID: <20121120094449.GG25445@distanz.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-11-19 at 19:21:50 +0100, Bill Pemberton <wfp5p@virginia.edu> wrote:
> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.
> 
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Jiri Slaby <jirislaby@gmail.com> 
> Cc: Alan Cox <alan@linux.intel.com> 
> Cc: Tobias Klauser <tklauser@distanz.ch> 
> Cc: Lucas Tavares <lucaskt@linux.vnet.ibm.com> 
> Cc: "David S. Miller" <davem@davemloft.net> 
> Cc: Peter Korsgaard <jacmet@sunsite.dk> 
> Cc: Tony Prisk <linux@prisktech.co.nz> 
> Cc: linuxppc-dev at lists.ozlabs.org 
> Cc: linux-serial at vger.kernel.org 
> Cc: nios2-dev at sopc.et.ntust.edu.tw 
> Cc: linux-ia64 at vger.kernel.org 
> Cc: sparclinux at vger.kernel.org 
> Cc: linux-arm-kernel at lists.infradead.org 
> ---
[...]
>  drivers/tty/serial/altera_jtaguart.c        |  2 +-
>  drivers/tty/serial/altera_uart.c            |  2 +-

Acked-by: Tobias Klauser <tklauser@distanz.ch>
