From: horms@verge.net.au (Simon Horman)
Date: Wed, 21 Nov 2018 11:20:46 +0100
Subject: [PATCH] arm64: dts: renesas: r8a77990: ebisu: Add and enable
 CAN,FD device nodes
In-Reply-To: <20181119105508.GC932@kunai>
References: <20181118173424.4807-1-marek.vasut+renesas@gmail.com>
 <20181118230313.GB2553@kunai>
 <63e27a31-d599-4672-87b9-48b0f542313d@gmail.com>
 <20181119105508.GC932@kunai>
Message-ID: <20181121102046.vbimumaycuj225op@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2018 at 11:55:08AM +0100, Wolfram Sang wrote:
> 
> > > Same here, what was tested?
> > 
> > I connected the CN10 to Peak CANFD, brought both interfaces up at
> > 125kBd/250kBd for FD
> > $ ip link set canX up type can bitrate 125000 dbitrate 250000 fd on
> > 
> > And ran on either side:
> > $ cangen -m canX
> > and
> > $ candump -t d -dex canX
> > This should give a good mix of CAN messages.
> 
> Perfect, thanks!

Thanks, applied for v4.21.
