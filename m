From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 14 Sep 2012 16:44:57 -0700
Subject: [PATCH 21/24] serial: ks8695: use __iomem pointers for MMIO
In-Reply-To: <1347658492-11608-22-git-send-email-arnd@arndb.de>
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
 <1347658492-11608-22-git-send-email-arnd@arndb.de>
Message-ID: <20120914234457.GA24200@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 11:34:49PM +0200, Arnd Bergmann wrote:
> ARM is moving to stricter checks on readl/write functions,
> so we need to use the correct types everywhere.
> 
> Cc: Alan Cox <alan@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
