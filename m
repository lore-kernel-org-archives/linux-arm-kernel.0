From: horms@verge.net.au (Simon Horman)
Date: Mon, 5 Sep 2016 14:01:04 +0200
Subject: [PATCH 0/3] Add R8A7792/Wheat QSPI support
In-Reply-To: <1648590.FPpmBRoQyh@wasted.cogentembedded.com>
References: <1648590.FPpmBRoQyh@wasted.cogentembedded.com>
Message-ID: <20160905120104.GB24256@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 03, 2016 at 01:04:37AM +0300, Sergei Shtylyov wrote:
> Hello.
> 
>    Here's the set of 3 patches against Simon Horman's 'renesas.git' repo,
> 'renesas-devel-20160902-v4.8-rc4' tag plus the Wheat board patches posted this
> week. We're adding the R8A7792/Wheat QSPI clocks and device nodes. The board
> patch depends on the PFC driver QSPI patch in order for the QSPI pins to be
> configured...
> 
> [1/3] ARM: dts: r8a7792: add QSPI clock
> [2/3] ARM: dts: r8a7792: add QSPI support
> [3/3] ARM: dts: wheat: add QSPI support

Thanks, I have queued these up.
