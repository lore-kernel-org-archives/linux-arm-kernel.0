From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 17 Mar 2014 16:23:59 -0700
Subject: [PATCH v6 1/3] tty/serial: Add GPIOLIB helpers for controlling
 modem lines
In-Reply-To: <1394469951-21192-2-git-send-email-richard.genoud@gmail.com>
References: <1394469951-21192-1-git-send-email-richard.genoud@gmail.com>
 <1394469951-21192-2-git-send-email-richard.genoud@gmail.com>
Message-ID: <20140317232359.GA8943@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 10, 2014 at 05:45:49PM +0100, Richard Genoud wrote:
> This patch add some helpers to control modem lines (CTS/RTS/DSR...) via
> GPIO.
> This will be useful for many boards which have a serial controller that
> only handle CTS/RTS pins (or even just RX/TX).
> 
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I can't take this series through my tty tree as the non-tty patches
don't apply, so feel free to take them through whatever tree is needed.

greg k-h
