From: broonie@kernel.org (Mark Brown)
Date: Fri, 23 Jun 2017 12:11:17 +0100
Subject: [PATCH][spi-next] spi: stm32: fix range limit checks on div
In-Reply-To: <0133c805-c919-f115-7c94-65d88bed8ca2@st.com>
References: <20170622154142.22481-1-colin.king@canonical.com>
 <0133c805-c919-f115-7c94-65d88bed8ca2@st.com>
Message-ID: <20170623111117.yj33dqr4eg4v43wt@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 22, 2017 at 05:49:10PM +0200, Amelie DELAUNAY wrote:

> I'm preparing a v2 for the initial patchset introducing spi-stm32, if you
> agree, I can directly add your fix.

Please don't resubmit patches that have already been applied, you should
submit patches against current code in the tree you're expecting things
to be applied to.  If any updates are needed to a patch that's already
been applied you should submit incremental patches which make those
updates.  This avoids having to change published git commits which could
cause problems for people working against git.

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170623/869852e2/attachment.sig>
