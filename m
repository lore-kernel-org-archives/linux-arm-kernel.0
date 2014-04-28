From: yegor_sub1@visionsystems.de (Yegor Yefremov)
Date: Mon, 28 Apr 2014 07:52:30 +0200
Subject: [PATCH 3/5] tty/serial: Add GPIOLIB helpers for controlling modem
 lines
In-Reply-To: <1398437561-4289-4-git-send-email-richard.genoud@gmail.com>
References: <1398437561-4289-1-git-send-email-richard.genoud@gmail.com>
 <1398437561-4289-4-git-send-email-richard.genoud@gmail.com>
Message-ID: <535DEC9E.4070105@visionsystems.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.04.2014 16:52, Richard Genoud wrote:
> This patch add some helpers to control modem lines (CTS/RTS/DSR...) via
> GPIO.
> This will be useful for many boards which have a serial controller that
> only handle CTS/RTS pins (or even just RX/TX).
> 
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Tested-by: Yegor Yefremov <yegorslists@googlemail.com>

Yegor
