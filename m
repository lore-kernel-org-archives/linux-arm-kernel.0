From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 14 Jul 2015 10:53:25 +0800
Subject: [PATCH] arm: dts: ls1021a: add wakeup device ftm0 node for ls1021a
In-Reply-To: <1436150319-15122-1-git-send-email-b18965@freescale.com>
References: <1436150319-15122-1-git-send-email-b18965@freescale.com>
Message-ID: <20150714025324.GA4104@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 06, 2015 at 10:38:39AM +0800, Alison Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> Add ftm0 node, cause of ftm0 can be set as a alarm before system
> going to deep sleep.
> 
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

Since you're forwarding the patch, you should add your SoB.  Also, for
sake of consistency, please use "ARM: " as subject prefix for all
patches sent to me.

Shawn
