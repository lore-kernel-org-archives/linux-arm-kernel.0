From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 4 Dec 2015 17:00:37 +0300
Subject: [PATCH 0/2] Add R8A7791 EtherAVB DT support
In-Reply-To: <2926317.Iq110C4Bmk@wasted.cogentembedded.com>
References: <2926317.Iq110C4Bmk@wasted.cogentembedded.com>
Message-ID: <56619C85.6040102@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12/3/2015 1:19 AM, Sergei Shtylyov wrote:

>     Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
> 'renesas-devel-20151201-v4.4-rc3' tag. Here we add the EtherAVB device tree
> support for the R8A7791 SoC. The 2nd patch depends on the Simon's recent
> EtherAVB driver patches in order to work...

    Well, not exactly "work", as the node is disabled. Anyway, Simon's patches 
got merged to net-next.git by Dave, so I think this series can be merged now 
as well...

> [1/2] ARM: shmobile: r8a7791: add EtherAVB clock
> [2/2] ARM: shmobile: r8a7791: add EtherAVB DT support

MBR, Sergei
