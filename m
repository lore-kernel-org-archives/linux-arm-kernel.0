From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 24 Sep 2016 22:11:39 +0800
Subject: [PATCH v6 2/4] arm64: dts: Add timer erratum property for
 LS2080A and LS1043A
In-Reply-To: <57E53FBB.9090208@arm.com>
References: <1474533318-7796-1-git-send-email-oss@buserror.net>
 <1474533318-7796-2-git-send-email-oss@buserror.net>
 <57E53FBB.9090208@arm.com>
Message-ID: <20160924141139.GB11051@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2016 at 03:44:11PM +0100, Marc Zyngier wrote:
> With a commit message along the lines of:
> 
> Both the LS1043A and LS2080A platforms are affected by the Freescale
> A008585 erratum. Advertise it in their respective device trees.

<snip>

> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks, Marc.  I queued up the patch with the suggested commit log
added.

Shawn
