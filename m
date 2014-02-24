From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 24 Feb 2014 13:54:21 -0500
Subject: [PATCH] ARM: Kirkwood: Remove redundant kexec code
In-Reply-To: <1393265364-29241-1-git-send-email-andrew@lunn.ch>
References: <1393265364-29241-1-git-send-email-andrew@lunn.ch>
Message-ID: <20140224185421.GB1010@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 24, 2014 at 07:09:24PM +0100, Andrew Lunn wrote:
> The PCIe driver has been fully clock aware for quite a while.  Remove
> the kexec code to enable the PCIe clock, since the PCIe driver will do
> the right thing.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/mach-kirkwood/board-dt.c | 5 -----
>  1 file changed, 5 deletions(-)

Applied to mvebu/soc-kw with Arnd's Ack.  Also, added the comment to the
commit log regarding the build error it was fixing.

thx,

Jason.
