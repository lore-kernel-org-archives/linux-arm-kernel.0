From: olof@lixom.net (Olof Johansson)
Date: Tue, 11 Mar 2014 12:49:19 -0700
Subject: [PATCH for 3.14] ARM: at91: fix network interface ordering for
 sama5d36
In-Reply-To: <1394462238-22313-1-git-send-email-nicolas.ferre@atmel.com>
References: <1394462238-22313-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20140311194919.GB31877@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 10, 2014 at 03:37:18PM +0100, Nicolas Ferre wrote:
> From: Boris BREZILLON <b.brezillon.dev@gmail.com>
> 
> On the newly introduced sama5d36, Gigabit and 10/100 Ethernet network
> interfaces are probed in a different order than for the sama5d35.
> Moreover, users are accustomed to this order in bootloaders and backports
> for older kernel revisions.
> So this patch switches DT node order as it is done for the other dual-Ethernet
> sama5d3 SoC.
> Better interface numbering which does not depend on DT node order is being
> developed for stronger interface identification.
> 
> Signed-off-by: Boris BREZILLON <b.brezillon.dev@gmail.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> Olof, Arnd and Kevin,
> 
> I would like to include this fix in 3.14-final.
> I do not have anymore patch for an at91-3.14-fixes branch so I only send this
> single patch to you. Can you still take it?

Sure, applied now.


-Olof
