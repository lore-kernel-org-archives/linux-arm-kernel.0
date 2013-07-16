From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 16 Jul 2013 16:28:37 +0400
Subject: [PATCH v4 0/3]  ARM: shmobile: lager: enable Ether
In-Reply-To: <7990652.CKWzcoj3FL@avalon>
References: <1372663234-13486-1-git-send-email-horms+renesas@verge.net.au>
 <7990652.CKWzcoj3FL@avalon>
Message-ID: <51E53C75.10904@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 16-07-2013 13:42, Laurent Pinchart wrote:

>> this short series enables the on-board ethernet
>> of the r8a7790 SoC for on lager board.

>> It has a run-time dependency on
>> "sh_eth: add support for r8a7790 SoC"

>> It has been built on top of renesas-next-20130701.

> Do you plan to respin this series on top of your latest devel branch ? I've
> quickly rebased it and now get receive FIFO overflows when booting over NFS,
> followed by the kernel disabling the sh-eth IRQ.

    That disabling of IRQ should have been fixed in 3.10.

WBR, Sergei
