From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 22 Sep 2016 07:08:44 +0200
Subject: [PATCH v2 5/6] misc: sram: add Atmel securam support
In-Reply-To: <20160921220939.27924-6-alexandre.belloni@free-electrons.com>
References: <20160921220939.27924-1-alexandre.belloni@free-electrons.com>
 <20160921220939.27924-6-alexandre.belloni@free-electrons.com>
Message-ID: <20160922050844.GA12248@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2016 at 12:09:38AM +0200, Alexandre Belloni wrote:
> The Atmel secure SRAM is connected to a security module and may be erased
> automatically under certain conditions. For that reason, it is necessary to
> wait for the security module to flag that SRAM accesses are allowed before
> accessing it.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
>  drivers/misc/sram.c | 42 +++++++++++++++++++++++++++++++++++-------
>  1 file changed, 35 insertions(+), 7 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
