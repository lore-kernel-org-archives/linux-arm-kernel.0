From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sat, 12 Dec 2015 22:03:25 -0800
Subject: [PATCH 05/11] tty: amba-pl011: add register lookup table
In-Reply-To: <E1Ztcve-0007CO-UO@rmk-PC.arm.linux.org.uk>
References: <20151103134349.GV8644@n2100.arm.linux.org.uk>
 <E1Ztcve-0007CO-UO@rmk-PC.arm.linux.org.uk>
Message-ID: <20151213060325.GA23244@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 03, 2015 at 02:51:18PM +0000, Russell King wrote:
> Add a register lookup table, which allows the register offsets to be
> adjusted on a per-port basis.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/tty/serial/amba-pl011.c | 33 ++++++++++++++++++++++++-
>  drivers/tty/serial/amba-pl011.h | 53 ++++++++++++++++++++++-------------------
>  2 files changed, 60 insertions(+), 26 deletions(-)

I'm guessing I should stop here in the series, so I haven't applied
this, or any patch after this to my tree.  Please resend what you have
left over as I think you have updates.

thanks,

greg k-h
