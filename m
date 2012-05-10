From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 10 May 2012 10:30:33 +0100
Subject: [PATCH 2/6] ASoC: mxs: use devm_clk_get for mxs_saif_probe
In-Reply-To: <CAAQ0ZWRtwwpToK9J5EbJvRrKnzGn6SrkDgNumat1b3vAS4ytUw@mail.gmail.com>
References: <1336639333-11561-1-git-send-email-shawn.guo@linaro.org>
 <1336639333-11561-3-git-send-email-shawn.guo@linaro.org>
 <20120510091332.GF3908@opensource.wolfsonmicro.com>
 <CAAQ0ZWRtwwpToK9J5EbJvRrKnzGn6SrkDgNumat1b3vAS4ytUw@mail.gmail.com>
Message-ID: <20120510093032.GI3908@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 05:17:27PM +0800, Shawn Guo wrote:
> On 10 May 2012 17:13, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > Please stop submitting devm_clk_get() changes until it's in mainline, as
> > I've said with all the similar changs this can't be applied until that
> > API can be merged up into ASoC.

> Russell's clkdev branch will show up in arm-soc as a dependency
> branch.  So if you are ok with the series go through arm-soc, we will
> be fine.

Well, if Russell's happy with that being merged into other trees I could
just pull it into ASoC?  Or we could just wait, or if this is really
separate to everything else why not just apply it on the clkdev branch
rather than worrying about some complicated arrangement?

This is just a trivial cleanup to use new APIs...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120510/286fd5ab/attachment-0001.sig>
