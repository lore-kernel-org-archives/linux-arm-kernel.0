From: balbi@ti.com (Felipe Balbi)
Date: Wed, 18 Dec 2013 09:40:21 -0600
Subject: [PATCH 0/7] usb: dwc3: pm_runtime implementation
In-Reply-To: <20131218153614.GB1593@saruman.home>
References: <1386884325-11440-1-git-send-email-balbi@ti.com>
 <20131217233140.GA21267@psi-dev26.jf.intel.com>
 <20131217233554.GB21267@psi-dev26.jf.intel.com>
 <20131218153614.GB1593@saruman.home>
Message-ID: <20131218154021.GC1593@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 09:36:14AM -0600, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Dec 17, 2013 at 03:35:54PM -0800, David Cohen wrote:
> > On Tue, Dec 17, 2013 at 03:31:40PM -0800, David Cohen wrote:
> > > On Thu, Dec 12, 2013 at 03:38:38PM -0600, Felipe Balbi wrote:
> > > > hi all,
> > > > 
> > > > these patches add pm_runtime support for all glue layers.
> > > > 
> > > > I plan to add pm_runtime support for dwc3 after these
> > > > patches are merged upstream.
> > > > 
> > > > Please test.
> > > 
> > > At first time I failed to notice you were removing #ifdef's around pm
> > > callback functions. Instead of saying DWC3 will start to have warnings
> > > when CONFIG_PM is not selected, I'd say your patch set is now a
> > > dependence of my RFC :)
> > 
> > I guess I said it in wrong order :P
> > Your patch set depends on my RFC.
> 
> Or I just modify my patchset a little bit for now ;-)

nah, it looks horrible with all those ifdefs around. I'll delay my
patch series.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131218/80debeb2/attachment.sig>
