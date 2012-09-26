From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 26 Sep 2012 13:57:32 -0700
Subject: [PATCH v3 0/4] lis3: lis3lv02d_i2c: Add device tree support
In-Reply-To: <20120926135412.c6813bb1.akpm@linux-foundation.org>
References: <1347866602-2088-1-git-send-email-anilkumar@ti.com>
 <20120926202400.GA27830@kroah.com>
 <20120926133450.8beeed6e.akpm@linux-foundation.org>
 <20120926204403.GA23921@kroah.com>
 <20120926135412.c6813bb1.akpm@linux-foundation.org>
Message-ID: <20120926205732.GA11780@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 26, 2012 at 01:54:12PM -0700, Andrew Morton wrote:
> On Wed, 26 Sep 2012 13:44:03 -0700
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Wed, Sep 26, 2012 at 01:34:50PM -0700, Andrew Morton wrote:
> > > On Wed, 26 Sep 2012 13:24:00 -0700
> > > Greg KH <gregkh@linuxfoundation.org> wrote:
> > > 
> > > > On Mon, Sep 17, 2012 at 12:53:18PM +0530, AnilKumar Ch wrote:
> > > > > Adds device tree support to lis3lv02d_i2c driver. Along with this
> > > > > DT init is moved from core driver to individual drivers, with the
> > > > > current implementation some pdata is missing in lis3lv02d_i2c driver.
> > > > > 
> > > > > Also adds platform data for lis331dlh driver to am335x-EVM. These
> > > > > patches were tested on AM335x-EVM.
> > > > 
> > > > None of these patches apply to any tree that I know of, what did you do
> > > > them against?  Please redo them against the char-next branch of
> > > > linux-next and resend them if you wish to see them applied.
> > > 
> > > Presumably they're against eariler patches whcih you don't have.  I'm
> > > presently sitting on
> > > 
> > > drivers-misc-lis3lv02d-add-generic-dt-matching-code.patch
> > > drivers-misc-lis3lv02d-add-generic-dt-matching-code-fix.patch
> > > drivers-misc-lis3lv02d-lis3lv02d_spic-add-dt-matching-table-passthru-code.patch
> > > drivers-misc-lis3lv02d-lis3lv02d_spic-add-dt-matching-table-passthru-code-fix.patch
> > > drivers-misc-lis3lv02d-lis3lv02d_spic-add-dt-matching-table-passthru-code-fix-fix.patch
> > > drivers-misc-lis3lv02d-remove-lis3lv02d-driver-dt-init.patch
> > > drivers-misc-lis3lv02d-lis3lv02d_spic-add-lis3lv02d-device-tree-init.patch
> > > drivers-misc-lis3lv02d-lis3lv02d_spic-add-lis3lv02d-device-tree-init-fix.patch
> > > drivers-misc-lis3lv02d-lis3lv02d_i2cc-add-lis3lv02d-device-tree-init.patch
> > > drivers-misc-lis3lv02d-lis3lv02d_i2cc-add-lis3lv02d-device-tree-init-fix.patch
> > > drivers-misc-lis3lv02d-fix-some-comments-specific-to-lis331dlh-driver.patch
> > 
> > Care to send them to me so that I can get them to Linus for the 3.7
> > merge window?
> 
> OK.
> 
> >  I do keep the char-misc tree for these types of things :)
> 
> I've actually been doing this miscdev driver since day one.  I'm happy
> to hand over the keys but please review the patches carefully and try not to
> miss stuff!

Will do, thanks.

greg k-h
