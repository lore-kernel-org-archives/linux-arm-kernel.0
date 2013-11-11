From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 11 Nov 2013 15:51:41 +0100
Subject: SPARSE_IRQ on Kirkwood
In-Reply-To: <5280ED8B.5060206@keymile.com>
References: <51E6F9E3.9030302@keymile.com>
 <5280ED8B.5060206@keymile.com>
Message-ID: <20131111145141.GC3489@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 11, 2013 at 03:45:31PM +0100, Gerlando Falauto wrote:
> Hi,
> 
> a few months later, my understanding has not changed much... could
> anyone please shed some light?

I _think_ sparse_IRQ is a pre-requisite for multiarch kernel. So it is
something we definitely want to do. I've no idea what is actually
required, but i do have it somewhere near the top of my TODO list.

	  Andrew
