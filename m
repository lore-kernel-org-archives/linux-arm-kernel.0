From: greg@kroah.com (Greg KH)
Date: Mon, 14 Nov 2011 11:21:47 -0800
Subject: [PATCH v2 2/2] USB: ehci-tegra: add probing through device tree
In-Reply-To: <1320433960-18173-2-git-send-email-olof@lixom.net>
References: <1320433960-18173-1-git-send-email-olof@lixom.net>
 <1320433960-18173-2-git-send-email-olof@lixom.net>
Message-ID: <20111114192147.GA28643@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2011 at 12:12:40PM -0700, Olof Johansson wrote:
> Rely on platform_data being passed through auxdata for now; more elaborate
> bindings for phy config and tunings to be added.
> 
> v2: moved vbus-gpio check to the helper function, added check for !of_node,
>     added usb2 clock to board-dt table.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
