From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 21 Jun 2013 21:51:19 -0400 (EDT)
Subject: [PATCH 0/8] ARM: mm: Extend the runtime patch stub for PAE systems
In-Reply-To: <1371858502-10083-1-git-send-email-santosh.shilimkar@ti.com>
References: <1371858502-10083-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <alpine.LFD.2.03.1306212149130.18597@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Jun 2013, Santosh Shilimkar wrote:

> Based on discussion/debate on Cyril's generic code patching framework,
> we cooked up this series which basically trying to extend the existing
> v2p runtime patching for LPAE machines which can have physical memory
> beyond 4 GB. Keystone is one such ARM machine.
> 
> We think the 64 bit patching can be still made better than the proposed
> patch in the series and hence seeking expert comments from RMK, Nico and
> others. Last patch in the series added to just give perspective on how
> machine code will make use of the available bits from the series.

FYI I'm currently on vacation and only handling quick emails.

I'll review your series in a week or so.


Nicolas
