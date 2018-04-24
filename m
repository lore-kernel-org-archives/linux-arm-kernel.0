From: horms@verge.net.au (Simon Horman)
Date: Tue, 24 Apr 2018 11:20:32 +0200
Subject: [PATCH 0/3] Add R8A77980/Condor PFC support
In-Reply-To: <4b325d8a-f018-5279-17b9-7fa8aac5b4da@cogentembedded.com>
References: <88e52531-e538-8685-110a-1a2e79a3fe49@cogentembedded.com>
 <4b325d8a-f018-5279-17b9-7fa8aac5b4da@cogentembedded.com>
Message-ID: <20180424092032.kuxk2irgh6y27kax@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2018 at 08:33:20PM +0300, Sergei Shtylyov wrote:
> On 03/09/2018 03:04 PM, Sergei Shtylyov wrote:
> 
> > Here's the set of 3 patches against Simon Horman's 'renesas.git' repo's
> > 'renesas-devel-20180308-v4.16-rc4' tag.  We're adding the R8A77980 PFC node
> > and then describing the pins for SCIF0 and EtherAVB devices declared earlier.
> > These patches depend on the R8A77980 PFC support in order to work properly.
> 
>   ... and their time has finally come! Please merge.
> 
> > [1/3] arm64: dts: renesas: r8a77980: add PFC support
> > [2/3] arm64: dts: renesas: condor: add SCIF0 pins
> > [3/3] arm64: dts: renesas: condor: add EtherAVB pins

Thanks, applied.
