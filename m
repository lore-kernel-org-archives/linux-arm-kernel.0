From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Fri, 2 Sep 2016 12:50:39 +0000
Subject: [PATCH v2 1/3] ARM: dts: r7s72100: add ethernet clock to device
 tree
In-Reply-To: <20160902082604.GD16669@verge.net.au>
References: <20160901155430.23400-1-chris.brandt@renesas.com>
 <20160902014012.9383-1-chris.brandt@renesas.com>
 <20160902082604.GD16669@verge.net.au>
Message-ID: <SG2PR06MB116533792940F6E3193E7EDB8AE50@SG2PR06MB1165.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/2/2016, Simon Horman wrote:
> For future submissions please consider:
> 1. Supplying a cover letter (git format-patch has a --cover-letter option)
>    for patch-sets comprising more than one patch. This allows you to describe
>    an overview of what the series as a whole achieves. And is also
>    convenient for maintainers to reply to when accepting your patches.

OK. I can do that.


> 2. Starting a new thread for each new version of a patch/patch-set.

Does that mean to NOT use --in-reply-to= when submitting a v2,v3,etc... ????



One more question:
Can I submit a patches series now that just adds all the MSTP clock nodes that I'll be working on for the next couple weeks? (USB, SDHI, MMC)
Or, do I have to wait till I have the drivers working?
Or, better yet, can I add all the MSTP clocks that will probably get used at some point (basically, everything that we're using today in our 3.14 BSP).

Chris
