From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 12 Aug 2013 11:27:42 -0700
Subject: [PATCH v4 21/31] serial: mpc512x: switch to CCF names in clock
 lookup
In-Reply-To: <1375821851-31609-22-git-send-email-gsi@denx.de>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
 <1375821851-31609-22-git-send-email-gsi@denx.de>
Message-ID: <20130812182742.GB20233@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 06, 2013 at 10:44:01PM +0200, Gerhard Sittig wrote:
> after device tree based clock lookup became available, the peripheral
> driver need no longer construct clock names which include the PSC index,
> remove the "psc%d_mclk" template and unconditionally use 'mclk'
> 
> acquire and release the 'ipg' clock for register access as well
> 
> Signed-off-by: Gerhard Sittig <gsi@denx.de>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
