From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 25 Sep 2012 20:51:27 +0100
Subject: [RFC PATCH 0/3] ARM: use C pre-processor with dtc
In-Reply-To: <1348601746.5565.18@snotra>
References: <1348599998-2729-1-git-send-email-swarren@wwwdotorg.org>
 <1348601746.5565.18@snotra>
Message-ID: <20120925195127.GA19350@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2012 at 02:35:46PM -0500, Scott Wood wrote:

> Do you have an example of where you'd actually benefit from this?
> I'd think most things could either be done reasonably well with
> what's built into DTC (see what we've done in
> arch/powerpc/boot/dts/fsl), or would need math expression support in
> DTC (or has that been added?).

The constant example is the magic numbers we need to embed into DTs for
things like interrupt modes, making them human readable would be a real
win.
