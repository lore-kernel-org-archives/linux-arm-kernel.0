From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 18 Aug 2016 21:00:47 +0300
Subject: [PATCH 0/2] Add R8A7792 DU support
In-Reply-To: <4031442.KeMCTMarLN@wasted.cogentembedded.com>
References: <4031442.KeMCTMarLN@wasted.cogentembedded.com>
Message-ID: <31faa5c3-d65f-0c1f-b62d-7f1882d19728@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 08/05/2016 09:24 PM, Sergei Shtylyov wrote:

>    Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
> 'renesas-devel-20160725-v4.7-rc7' tag. We're adding the R8A7792 DU clocks and
> device nodes. They have been tested on the Blanche board -- I'm not posting the
> Blanche patch only because it also has some strange interaction with the
> Ethernet chip, so that NFS root can't work anymore...

    Looks like this effect is confined to only one Blanche board, so I'm going 
to start posting the pending patches.

> [1/2] ARM: dts: r8a7792: add DU clocks
> [2/2] ARM: dts: r8a7792: add DU support

WBR, Sergei
