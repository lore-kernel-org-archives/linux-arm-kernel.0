From: joe@perches.com (Joe Perches)
Date: Tue, 22 Aug 2017 19:33:45 -0700
Subject: [PATCH] staging: fsl-mc: be consistent when checking strcmp()
 returns
In-Reply-To: <20170823014031.GA14400@kroah.com>
References: <20170817115504.4308-1-laurentiu.tudor@nxp.com>
 <20170823014031.GA14400@kroah.com>
Message-ID: <1503455625.6933.12.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-08-22 at 18:40 -0700, Greg KH wrote:
> On Thu, Aug 17, 2017 at 02:55:04PM +0300, laurentiu.tudor at nxp.com wrote:
> > From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > 
> > Throughout the driver we use == 0 / != 0 to check strcmp() returns except
> > this place, so fix it.
> 
> You will just get someone else fixing it as it is not what checkpatch
> recommends, so just leave it as-is please.

No.  That's not correct.

checkpatch does not make a recommendation about
style use with the strcmp family of functions.
