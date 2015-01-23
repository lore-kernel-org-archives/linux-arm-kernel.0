From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 23 Jan 2015 15:29:56 +0000
Subject: [PATCH] arm64: add ioremap physical address information
In-Reply-To: <CAHkaATSM=V+BNZvAXC+VG6NDjOK9m0ZP3Q=SUaoxtgDw4SKZog@mail.gmail.com>
References: <CAHkaATSM=V+BNZvAXC+VG6NDjOK9m0ZP3Q=SUaoxtgDw4SKZog@mail.gmail.com>
Message-ID: <20150123152956.GA9557@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 26, 2014 at 04:52:10PM +0000, Min-Hua Chen wrote:
> In /proc/vmallocinfo, it's good to show the physical address
> of each ioremap in vmallocinfo. Add physical address information
> in arm64 ioremap.
> 
> 0xffffc900047f2000-0xffffc900047f4000    8192 _nv013519rm+0x57/0xa0
> [nvidia] phys=f8100000 ioremap
> 0xffffc900047f4000-0xffffc900047f6000    8192 _nv013519rm+0x57/0xa0
> [nvidia] phys=f8008000 ioremap
> 0xffffc90004800000-0xffffc90004821000  135168 e1000_probe+0x22c/0xb95
> [e1000e] phys=f4300000 ioremap
> 0xffffc900049c0000-0xffffc900049e1000  135168 _nv013521rm+0x4d/0xd0
> [nvidia] phys=e0140000 ioremap
> 
> Signed-off-by: Min-Hua Chen <orca.chen@gmail.com>

Applied. Thanks.

-- 
Catalin
