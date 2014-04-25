From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 25 Apr 2014 08:58:47 -0700
Subject: [PATCH 0/5] tty/serial: Add helpers to use GPIOs to control
 modem lines and implement atmel_serial.c
In-Reply-To: <1398437561-4289-1-git-send-email-richard.genoud@gmail.com>
References: <1398437561-4289-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <20140425155847.GC22879@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 25, 2014 at 04:52:36PM +0200, Richard Genoud wrote:
> This patch series is a leftover of http://www.spinics.net/lists/arm-kernel/msg314242.html
> that missed 3.15 because it caused merge conflicts.
> 
> The 1st patch may be applied as a fix for 3.15-rc, since it correct a
> device tree binding documentation example.
> 
> Greg, for you to decide if it's worth it or not !

Why am I the one tho decides if it is worth it?  If it's up to me, I'll
just say "no", as I sure don't need this for any of my machines...

See, that was easy :)

greg k-h
