From: balbi@ti.com (Felipe Balbi)
Date: Wed, 19 Sep 2012 20:29:40 +0300
Subject: [PATCH 2/4] usb: dwc3: Fix gadget pullup in SS mode
In-Reply-To: <20120919172442.GA7784@arwen.pp.htv.fi>
References: <1348054229-27362-1-git-send-email-kishon@ti.com>
 <1348054229-27362-3-git-send-email-kishon@ti.com>
 <20120919115306.GG3772@arwen.pp.htv.fi>
 <CAEgRx2zOVn0zV39-cuPuj4n4HRgQmywy_NY4KTe0qEgeC+NEkw@mail.gmail.com>
 <20120919160450.GA7510@arwen.pp.htv.fi>
 <CAEgRx2yXStORBknr2hoMcobMO8wFGuKr4bvzZwEQHQQcHVH76Q@mail.gmail.com>
 <20120919172442.GA7784@arwen.pp.htv.fi>
Message-ID: <20120919172939.GC7784@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi again,

On Wed, Sep 19, 2012 at 08:24:44PM +0300, Felipe Balbi wrote:
> > > at minimum this should've come with a proper revision check anyway.
> > >
> > 
> > Actually most of it is under a rev check :)
> 
> fair enough.

one extra comment here. That revision check is not related to the
silicon errata you mention. That revision check is there because the bit
definition of that particular register has changed a little bit, so
we're just handling a slightly different programming model between older
and newer revisions.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120919/b82b1a27/attachment.sig>
