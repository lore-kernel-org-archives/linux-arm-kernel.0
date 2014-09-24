From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 24 Sep 2014 21:25:16 +0200 (CEST)
Subject: [RFC Part2 v1 00/21] Enable hierarchy irqdomian on x86 platforms
In-Reply-To: <542279D0.1040603@jp.fujitsu.com>
References: <1410444228-3134-1-git-send-email-jiang.liu@linux.intel.com>
 <542279D0.1040603@jp.fujitsu.com>
Message-ID: <alpine.DEB.2.10.1409242122380.4604@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Sep 2014, Yasuaki Ishimatsu wrote:
> I cannot imagine why the feature makes x86 irq architecture much more clear
> and more easy to maintain in this description. Of course, I have read the
> following threads:
> 
> https://lkml.org/lkml/2014/9/11/101

Here is the long version of the idea:

     https://lkml.org/lkml/2014/8/26/707

Short version is:

Separate the irq handling entities in a clear layered way instead of
having vector/[io]apic specific knowledge/data in places like msi,
remap etc.

Thanks,

	tglx
