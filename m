From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 28 Aug 2017 14:51:29 +0200
Subject: [PATCH 3/8] tty/bcm63xx_uart: use refclk for the expected clock
 name
In-Reply-To: <20170802093429.12572-4-jonas.gorski@gmail.com>
References: <20170802093429.12572-1-jonas.gorski@gmail.com>
 <20170802093429.12572-4-jonas.gorski@gmail.com>
Message-ID: <20170828125129.GA2652@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 02, 2017 at 11:34:24AM +0200, Jonas Gorski wrote:
> We now have the clock available under refclk, so use that.
> 
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
