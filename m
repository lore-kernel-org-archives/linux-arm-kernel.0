From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 21 Mar 2012 20:10:16 +0000
Subject: [PATCH v7 1/3] Documentation: common clk API
In-Reply-To: <4F6A3446.9020809@codeaurora.org>
References: <4F6A2042.9030302@codeaurora.org>
 <20120321190741.GL3226@opensource.wolfsonmicro.com>
 <20120321193304.GO9859@atomide.com>
 <4F6A2EF5.3010008@codeaurora.org>
 <20120321195656.GN3226@opensource.wolfsonmicro.com>
 <4F6A3446.9020809@codeaurora.org>
Message-ID: <20120321201015.GP3226@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2012 at 01:04:22PM -0700, Saravana Kannan wrote:

> Sure, prepare/unprepare are already there in the .h file. But they
> are stubs and have no impact till we move to the common clock
> framework or platforms move to them with their own implementation
> (certainly not happening in upstream, so let's leave that part out
> of this discussion).

> So. IMO, for all practical purposes, common clk fwk forces the move
> to these new APIs and hence IMO forces the new APIs.

Sure, if you want to look at it from that point of view - anything
wanting to run on a platform which uses the generic API needs to use
them, but there's no blocker on the user from this (it can convert with
or without the platform it runs on) - but it's hardly a tough sell.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120321/698cf6b8/attachment.sig>
