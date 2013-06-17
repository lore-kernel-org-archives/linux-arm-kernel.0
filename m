From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sun, 16 Jun 2013 20:00:05 -0700
Subject: [PATCH 1/2] serial: sh-sci: HSCIF support
In-Reply-To: <1371436934-27744-2-git-send-email-horms+renesas@verge.net.au>
References: <1371436934-27744-1-git-send-email-horms+renesas@verge.net.au>
 <1371436934-27744-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20130617030005.GC12522@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 11:42:13AM +0900, Simon Horman wrote:
> From: Ulrich Hecht <ulrich.hecht@gmail.com>
> 
> Adds support for "High Speed Serial Communications Interface with FIFO",
> essentially a SCIF with 128-byte FIFOs and more accurate baud rate
> generator.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
> Acked-by: Paul Mundt <lethal@linux-sh.org>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
