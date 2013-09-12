From: sameo@linux.intel.com (Samuel Ortiz)
Date: Thu, 12 Sep 2013 11:28:11 +0200
Subject: [PATCH v2 6/9] mfd: wm8994: convert to use I2C core runtime PM
In-Reply-To: <20130912092447.GJ7393@intel.com>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
 <1378913560-2752-7-git-send-email-mika.westerberg@linux.intel.com>
 <20130911161242.GA13015@zurbaran> <20130912092447.GJ7393@intel.com>
Message-ID: <20130912092811.GH13015@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 12, 2013 at 12:24:47PM +0300, Mika Westerberg wrote:
> On Wed, Sep 11, 2013 at 06:12:43PM +0200, Samuel Ortiz wrote:
> > I think it would make more sense for you to merge that one together with
> > the related i2c changes. If you prefer that I take it through MFD,
> > please let me know.
> 
> I'm hoping that Wolfram takes all the I2C related patches to his tree.
If Wolfram prepares an immutable branch for that, I can pull it in
mfd-next and then merge the MFD patch on top of it.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
