From: olof@lixom.net (Olof Johansson)
Date: Fri, 14 Jun 2013 18:03:43 -0700
Subject: [PATCH 1/2] serial: sh-sci: HSCIF support
In-Reply-To: <1371106854-25560-2-git-send-email-horms+renesas@verge.net.au>
References: <1371106854-25560-1-git-send-email-horms+renesas@verge.net.au>
 <1371106854-25560-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20130615010343.GO18124@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 04:00:53PM +0900, Simon Horman wrote:
> From: Ulrich Hecht <ulrich.hecht@gmail.com>
> 
> Adds support for "High Speed Serial Communications Interface with FIFO",
> essentially a SCIF with 128-byte FIFOs and more accurate baud rate
> generator.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
> Acked-by: Paul Mundt <lethal@linux-sh.org>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

I think this should go through Greg K-H, or at least get an Acked-by from him.

Especially since it adds and allocates new UAPI IDs.


-Olof
