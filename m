From: olof@lixom.net (Olof Johansson)
Date: Fri, 31 Jan 2014 15:01:03 -0800
Subject: [PATCH v2] MAINTAINERS: ARM: SiRF: use regex patterns to involve
 all SiRF drivers
In-Reply-To: <1388719453-12447-1-git-send-email-21cnbao@gmail.com>
References: <1388719453-12447-1-git-send-email-21cnbao@gmail.com>
Message-ID: <20140131230103.GA9804@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 03, 2014 at 11:24:13AM +0800, Barry Song wrote:
> From: Barry Song <Baohua.Song@csr.com>
> 
> instead of listing drivers one by one, use regex patterns to involve all
> SiRF drivers directly.
> this also adds sirf UART and watchdog drivers automatically from:
> drivers/tty/serial/sirfsoc_uart.*
> drivers/watchdog/sirfsoc_wdt.c
> 
> Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Applied to fixes for 3.14.


-Olof
