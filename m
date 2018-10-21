From: broonie@kernel.org (Mark Brown)
Date: Sun, 21 Oct 2018 15:02:26 +0100
Subject: [PATCH v2] ASoC: sun4i-i2s: move code from startup/shutdown
 hooks into pm_runtime hooks
In-Reply-To: <1716612.tSkIyEiKY2@anarsoul-thinkpad>
References: <20181016031141.16259-1-anarsoul@gmail.com>
 <6365837.9zzJEACKLf@anarsoul-thinkpad>
 <20181017210159.hni6ozm755orvzzg@flea>
 <1716612.tSkIyEiKY2@anarsoul-thinkpad>
Message-ID: <20181021140226.GF8554@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2018 at 09:18:18AM -0700, Vasily Khoruzhick wrote:
> On Wednesday, October 17, 2018 2:01:59 PM PDT Maxime Ripard wrote:
> > On Wed, Oct 17, 2018 at 08:36:26AM -0700, Vasily Khoruzhick wrote:
> > > On Wednesday, October 17, 2018 8:25:23 AM PDT Maxime Ripard wrote:
> > > > On Wed, Oct 17, 2018 at 07:41:55AM -0700, Vasily Khoruzhick wrote:
> > > > > On Wed, Oct 17, 2018 at 12:45 AM Maxime Ripard

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

> Mark, can you pick up this one please? Thanks!

Please resend, I dropped it due to the (initial) negative review
comments.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181021/b7ba89f4/attachment-0001.sig>
