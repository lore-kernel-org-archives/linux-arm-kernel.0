From: horms@verge.net.au (Simon Horman)
Date: Mon, 18 Jul 2016 11:09:45 +0900
Subject: [PATCH v2 0/3] Add R8A7792/Blanche PFC support
In-Reply-To: <5383928.8UnDsUpmkz@wasted.cogentembedded.com>
References: <5383928.8UnDsUpmkz@wasted.cogentembedded.com>
Message-ID: <20160718020944.GB25133@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 14, 2016 at 11:58:49PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
>    Here's the set of 3 patches against Simon Horman's 'renesas.git' repo,
> 'renesas-devel-20160711-v4.7-rc7' tag. We're adding the R8A7792 PFC node and
> then describe the pins for the SCIFs and SMSC LAN89218 Ethernet chip found on
> the Blanche board. These patches depend on the R8A7792 PFC driver patchset
> in order to work properly.
> 
> [1/3] ARM: dts: r8a7792: add PFC support
> [2/3] ARM: dts: blanche: add SCIF0/3 pins
> [3/3] ARM: dts: blanche: add Ethernet pins

Thanks, I have queued this up.
