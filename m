From: gregkh@suse.de (Greg KH)
Date: Mon, 10 Oct 2011 07:14:02 -0700
Subject: [PATCH] fix ehci alignment error
In-Reply-To: <20111010124154.464239811@gmail.com>
References: <20111010124154.464239811@gmail.com>
Message-ID: <20111010141402.GA21856@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 10, 2011 at 02:38:27PM +0200, Harro Haan wrote:
> The Kirkwood gave an unaligned memory access error on
> line 742 of drivers/usb/host/echi-hcd.c:
> "ehci->last_periodic_enable = ktime_get_real();"

What is "The Kirkwood"?  What size processor is this?
