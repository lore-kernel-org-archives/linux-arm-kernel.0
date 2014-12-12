From: broonie@kernel.org (Mark Brown)
Date: Fri, 12 Dec 2014 19:29:36 +0000
Subject: [PATCH v2 1/6] ASoC: dwc: Remove unnecessary debug messages and
 tests
In-Reply-To: <97f65b6037b9ac676f6ca7717a230a68cbe81fd1.1418372910.git.Andrew.Jackson@arm.com>
References: <cover.1418372910.git.Andrew.Jackson@arm.com>
 <97f65b6037b9ac676f6ca7717a230a68cbe81fd1.1418372910.git.Andrew.Jackson@arm.com>
Message-ID: <20141212192936.GT11764@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 12, 2014 at 09:25:00AM +0000, Andrew Jackson wrote:
> From: Andrew Jackson <Andrew.Jackson@arm.com>
> 
> The devm_XXX allocation functions print a message on failure,
> so additional messages are not required.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141212/9a14b0d0/attachment.sig>
