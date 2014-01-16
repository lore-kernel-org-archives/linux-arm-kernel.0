From: w@1wt.eu (Willy Tarreau)
Date: Thu, 16 Jan 2014 07:16:15 +0100
Subject: [PATCH net-next 0/2] net: mvneta: simple cleanups
In-Reply-To: <20140115.154122.1485420525760591929.davem@davemloft.net>
References: <cover.1389742334.git.arno@natisbad.org>
 <20140115.154122.1485420525760591929.davem@davemloft.net>
Message-ID: <20140116061615.GB15597@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Wed, Jan 15, 2014 at 03:41:22PM -0800, David Miller wrote:
> From: Arnaud Ebalard <arno@natisbad.org>
> Date: Wed, 15 Jan 2014 00:45:31 +0100
> 
> > 
> > Those two patches are intended for net-next. They apply on top of
> > performance improvements patches from Willy for mvneta driver.
> > They provide some simple cleanups for unused variables, function
> > params or return values.
> > 
> > Arnaud Ebalard (2):
> >   net: mvneta: mvneta_tx_done_gbe() cleanups
> >   net: mvneta: make mvneta_txq_done() return void
> 
> These patches do not apply to net-next, please respin.

They depend on the two series I sent, I verified that they apply well
once these two series are applied to net-next.

Would you prefer that we resend a complete series with all the patches
at once ?

Thanks,
Willy
