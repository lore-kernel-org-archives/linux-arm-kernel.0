From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 14 Jun 2017 12:49:45 +0200
Subject: [PATCH] tty/serial: Kconfig: remove AVR32
In-Reply-To: <20170613203509.32026-1-alexandre.belloni@free-electrons.com>
References: <20170613203509.32026-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170614104945.GA11354@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 13, 2017 at 10:35:09PM +0200, Alexandre Belloni wrote:
> AVR32 is now removed from the kernel, removed the config symbol that
> doesn't exist anymore. Also take the opportunity to reword the help to
> include sama5.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/tty/serial/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Does not apply to tty-next at all :(
