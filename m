From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 26 Aug 2013 15:53:15 +0400
Subject: [PATCH v2 0/2] R8A7779/Marzen: HPB-DMAC support for SDHI0
In-Reply-To: <20130826073626.GB10710@verge.net.au>
References: <201308252143.33458.sergei.shtylyov@cogentembedded.com>
 <20130826073626.GB10710@verge.net.au>
Message-ID: <521B41AB.8040005@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 26-08-2013 11:36, Simon Horman wrote:

>>     Here's the set of 2 patches against the Simon Horman's 'renesas.git' repo,
>> 'renesas-devel-20130823' tag. Here we add the HPB-DMAC platform code working on
>> R8A7779 and enable DMA for SDHI0 on Marzen. The patchset depends on the R-Car
>> HPB-DMAC driver patch posted earlier.

>> [1/2] ARM: shmobile: r8a7779: add HPB-DMAC support
>> [2/2] ARM: shmobile: Marzen: enable DMA for SDHI0

> Hi Sergei,

> have those patches been merged?

    No. The driver they depend on hasn't been merged yet.

> If so, do you expect them to appear in v3.12-rc1?

    I'm not sure what to expect at this point...

WBR, Sergei
