From: broonie@kernel.org (Mark Brown)
Date: Fri, 13 Sep 2013 13:10:59 +0100
Subject: [PATCH v2 1/9] i2c: prepare runtime PM support for I2C client
 devices
In-Reply-To: <20130913115035.GB7393@intel.com>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
 <1378913560-2752-2-git-send-email-mika.westerberg@linux.intel.com>
 <87vc25pvvm.fsf@linaro.org> <20130913065434.GZ7393@intel.com>
 <20130913095950.GA29403@sirena.org.uk>
 <20130913101611.GA7393@intel.com>
 <20130913103152.GE29403@sirena.org.uk>
 <20130913115035.GB7393@intel.com>
Message-ID: <20130913121059.GL29403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 13, 2013 at 02:50:35PM +0300, Mika Westerberg wrote:
> On Fri, Sep 13, 2013 at 11:31:52AM +0100, Mark Brown wrote:

> > Right, but this probably needs to be highlighted more since it's a very
> > surprising thing for I2C and is causing confusion.

> By highlighted more, do you mean something like adding a comment in the
> code about this or?

Perhaps, yes.  Or possibly the commit log is going to be enough going
forwards.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130913/22271e5d/attachment.sig>
