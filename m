From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 21 Mar 2012 19:56:56 +0000
Subject: [PATCH v7 1/3] Documentation: common clk API
In-Reply-To: <4F6A2EF5.3010008@codeaurora.org>
References: <4F6A2042.9030302@codeaurora.org>
 <20120321190741.GL3226@opensource.wolfsonmicro.com>
 <20120321193304.GO9859@atomide.com>
 <4F6A2EF5.3010008@codeaurora.org>
Message-ID: <20120321195656.GN3226@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2012 at 12:41:41PM -0700, Saravana Kannan wrote:
> On 03/21/2012 12:33 PM, Tony Lindgren wrote:
> >* Mark Brown<broonie@opensource.wolfsonmicro.com>  [120321 12:11]:

> >>These aren't new APIs, the clock API has been around since forever.

> I disagree. When I say clock API, I mean the actual functions and
> their semantics. Not the existence of a header file.

> The meaning of clk_enable/disable has been changed and they won't
> work without calling clk_prepare/unprepare. So, these are definitely
> new APIs. If it weren't new APIs, then none of the general drivers
> would need to change.

clk_prepare() and clk_unprepare() are already there for any clk.h user
and are stubbed in no matter what, they're really not a meaningful
barrier here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120321/008e43d2/attachment.sig>
