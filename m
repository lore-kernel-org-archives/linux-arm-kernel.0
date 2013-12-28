From: broonie@kernel.org (Mark Brown)
Date: Sat, 28 Dec 2013 14:52:09 +0000
Subject: [PATCH v2 4/7] mfd: ssbi: Add regmap read/write helpers
In-Reply-To: <20131226194133.GJ31766@codeaurora.org>
References: <1387831563-13535-1-git-send-email-sboyd@codeaurora.org>
 <1387831563-13535-5-git-send-email-sboyd@codeaurora.org>
 <20131224125443.GC30815@sirena.org.uk>
 <20131226194133.GJ31766@codeaurora.org>
Message-ID: <20131228145209.GF31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 26, 2013 at 11:41:33AM -0800, Stephen Boyd wrote:
> On 12/24, Mark Brown wrote:

> > Not a big deal but could these just be inlined in the headers?

> Sure, I can do that if I need to resend? The only benefit I see
> is two less symbols exported.

It also means that everything will be marginally faster since there
will be one less level of function call but yeah, there's little
practical benefit - it's a stylistic thing rather than a practical one.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131228/a41149d2/attachment.sig>
