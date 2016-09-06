From: horms@verge.net.au (Simon Horman)
Date: Tue, 6 Sep 2016 12:49:38 +0200
Subject: [PATCH v2 1/3] ARM: dts: r7s72100: add ethernet clock to device
 tree
In-Reply-To: <SG2PR06MB116533792940F6E3193E7EDB8AE50@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20160901155430.23400-1-chris.brandt@renesas.com>
 <20160902014012.9383-1-chris.brandt@renesas.com>
 <20160902082604.GD16669@verge.net.au>
 <SG2PR06MB116533792940F6E3193E7EDB8AE50@SG2PR06MB1165.apcprd06.prod.outlook.com>
Message-ID: <20160906104937.GF16304@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 02, 2016 at 12:50:39PM +0000, Chris Brandt wrote:
> On 9/2/2016, Simon Horman wrote:
> > For future submissions please consider:
> > 1. Supplying a cover letter (git format-patch has a --cover-letter option)
> >    for patch-sets comprising more than one patch. This allows you to describe
> >    an overview of what the series as a whole achieves. And is also
> >    convenient for maintainers to reply to when accepting your patches.
> 
> OK. I can do that.
> 
> 
> > 2. Starting a new thread for each new version of a patch/patch-set.
> 
> Does that mean to NOT use --in-reply-to= when submitting a v2,v3,etc... ????

I think so.

> One more question:
> Can I submit a patches series now that just adds all the MSTP clock nodes that I'll be working on for the next couple weeks? (USB, SDHI, MMC)
> Or, do I have to wait till I have the drivers working?
> Or, better yet, can I add all the MSTP clocks that will probably get used at some point (basically, everything that we're using today in our 3.14 BSP).

I think that would be ok. I would slightly prefer that MSTP patches are
added in such a way that they can be tested. But in this case I'm not
sure anyone would test them :^)
