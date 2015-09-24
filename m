From: koro.chen@mediatek.com (Koro Chen)
Date: Thu, 24 Sep 2015 09:39:49 +0800
Subject: [PATCH] ASoC: mediatek: Increase periods_min in capture
In-Reply-To: <20150923161253.GN30445@sirena.org.uk>
References: <1442213477-63721-1-git-send-email-koro.chen@mediatek.com>
 <1443002599.22786.2.camel@mtksdaap41>
 <20150923161253.GN30445@sirena.org.uk>
Message-ID: <1443058789.22786.11.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-09-23 at 09:12 -0700, Mark Brown wrote:
> On Wed, Sep 23, 2015 at 06:03:19PM +0800, Koro Chen wrote:
> > Any suggestion for this patch?
> > 
> > On Mon, 2015-09-14 at 14:51 +0800, Koro Chen wrote:
> > > In capture, there is chance that hw_ptr reported at IRQ is
> > > a little smaller than period_size due to internal AFE buffer.
> > > In the case of ping-pong buffer:
> 
> Please don't top post or send content free pings.  I'm not entirely sure
> what you're asking for here - the patch has been applied, what further
> suggestions were you looking for?
I am sorry about the top posting ping... will never do this again. 
OK thank you, now I see the patch is already in the tree, but I am sure
I didn't get the mail titled "Applied xxx to the asoc tree", so I didn't
know the patch status. Maybe something was wrong with the mail system?
