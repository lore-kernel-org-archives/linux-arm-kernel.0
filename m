From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 1 Oct 2013 12:35:06 -0400
Subject: [PATCH 2/3] ARM: kirkwood: Move the crypto node under the mbus
 node
In-Reply-To: <20130917184309.GE21230@obsidianresearch.com>
References: <20130917184309.GE21230@obsidianresearch.com>
Message-ID: <20131001163506.GA31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 17, 2013 at 12:43:09PM -0600, Jason Gunthorpe wrote:
> There should be no nodes that are not children of the mbus. Move
> the crypto node under the mbus.
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> ---
>  arch/arm/boot/dts/kirkwood.dtsi | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)

Applied to mvebu/dt

thx,

Jason.
