From: sre@kernel.org (Sebastian Reichel)
Date: Fri, 8 Dec 2017 18:06:10 +0100
Subject: [PATCH v4.14] Add support for bq27521 battery monitor
In-Reply-To: <cfa89227-e08a-849f-c886-723268ae657c@ti.com>
References: <20171109210615.GA27638@amd> <20171110103937.GA29900@amd>
 <20171201230649.GA27533@amd>
 <cfa89227-e08a-849f-c886-723268ae657c@ti.com>
Message-ID: <20171208170610.gbmlsgm7xzh2zpyn@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 04, 2017 at 09:20:33AM -0600, Andrew F. Davis wrote:
> On 12/01/2017 05:06 PM, Pavel Machek wrote:
> > Hi!
> > 
> >> This adds basic support for BQ27521 battery monitor, used in Nokia N9
> >> and N950. In particular, battery voltage is important to be able to
> >> tell when the battery is almost empty. Emptying battery on N950 is
> >> pretty painful, as flasher needs to be used to recover phone in such
> >> case.
> > 
> > Sebastian, ping? This one should not be too controversial.
>
> Acked-by: Andrew F. Davis <afd@ti.com>

Thanks, queued, I dropped the spurious change in twl.h and added the
dt-binding from the previous patch version, that was lost somehow.

> > If you could also apply the "shut down when battery is low", that
> > would be nice.

I only have one with values specific to N900 hardcoded in the
driver. That one can't be applied for obvious reasons.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171208/e6e946c7/attachment-0001.sig>
