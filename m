From: broonie@sirena.org.uk (Mark Brown)
Date: Wed, 2 Sep 2009 17:58:48 +0100
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <20090902031719.GK3838@prithivi.gnumonks.org>
References: <20090902031719.GK3838@prithivi.gnumonks.org>
Message-ID: <20090902165848.GG4012@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 02, 2009 at 12:17:19PM +0900, Harald Welte wrote:

> === s5m8751 PMIC ===
> * samsung has a mfd driver in their 2.6.28 based tree
> * only on special development board, not on stock SMDK
> * nonetheless, we want to submit mainline
> * lower priority, since not on SMDK

Didn't notice this before...  it might be worth bringing it forward
since the PMICs tend to cross a wide range of kernel subsystems.  This
means that it's often easiest to merge over several release cycles which
can lead to long delays.  Getting at least the MFD core part of the
driver merged sooner should help with that a lot since by the time it
becomes a priority the shared part may already be in mainline.
