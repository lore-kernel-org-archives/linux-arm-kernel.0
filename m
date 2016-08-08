From: horms@verge.net.au (Simon Horman)
Date: Mon, 8 Aug 2016 13:03:54 +0200
Subject: [PATCH] ARM: dts: r8a7792: fix misindented line
In-Reply-To: <4152284.qHAgBjWaW0@wasted.cogentembedded.com>
References: <1618499.8bcj8adpVO@wasted.cogentembedded.com>
 <4152284.qHAgBjWaW0@wasted.cogentembedded.com>
Message-ID: <20160808110354.GJ17838@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 06, 2016 at 12:52:39AM +0300, Sergei Shtylyov wrote:
> Commit 2a0900655d5e (ARM: dts: r8a7792: add I2C support) had a wrongly
> indented line at the end of the "aliases" subnode -- fix it.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> This patch is against the 'renesas-devel-20160725-v4.7-rc7' tag of Simon
> Horman's 'renesas.git' repo.

Thanks, I have queued this up for v4.9.
