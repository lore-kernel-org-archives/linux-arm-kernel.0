From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 21 Sep 2012 16:05:39 -0700
Subject: [RFC 2/3] ARM: move udc_pxa2xx.h to linux/platform_data
In-Reply-To: <E1TEzet-00077v-VD@rmk-PC.arm.linux.org.uk>
References: <20120921093530.GB31374@n2100.arm.linux.org.uk>
 <E1TEzet-00077v-VD@rmk-PC.arm.linux.org.uk>
Message-ID: <20120921230539.GE4918@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 10:36:27AM +0100, Russell King wrote:
> Move the PXA2xx/IXP4xx UDC header file into linux/platform_data as it
> only contains a driver platform data structure.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>


Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
