From: daniel.kiper@oracle.com (Daniel Kiper)
Date: Wed, 19 Apr 2017 21:29:06 +0200
Subject: [PATCH] arm64: xen: Implement EFI reset_system callback
In-Reply-To: <20170418134650.GL24360@codeblueprint.co.uk>
References: <20170405181417.15985-1-julien.grall@arm.com>
 <e5b548be-2ec3-9b4f-a456-929d5fb881ab@oracle.com>
 <b8c9c6cd-906a-2360-ca9f-d34a45258567@suse.com>
 <3f6f5853-cd08-8afc-f71a-b0c1545c7564@arm.com>
 <20170406142710.GE4372@olila.local.net-space.pl>
 <ed7f64f4-17db-e2a5-f362-b382666cbc36@suse.com>
 <20170406152040.GH4372@olila.local.net-space.pl>
 <e449f220-8db7-d58c-bdbf-47ccd6dd014b@arm.com>
 <20170406155453.GA3966@leverpostej>
 <20170418134650.GL24360@codeblueprint.co.uk>
Message-ID: <20170419192906.GO16658@olila.local.net-space.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 02:46:50PM +0100, Matt Fleming wrote:
> On Thu, 06 Apr, at 04:55:11PM, Mark Rutland wrote:
> >
> > Please, let's keep the Xen knowledge constrained to the Xen EFI wrapper,
> > rather than spreading it further.
> >
> > IMO, given reset_system is a *mandatory* function, the Xen wrapper
> > should provide an implementation.
> >
> > I don't see why you can't implement a wrapper that calls the usual Xen
> > poweroff/reset functions.
>
> I realise I'm making a sweeping generalisation, but adding
> EFI_PARAVIRT is almost always the wrong thing to do.

Why?

> I'd much prefer to see Mark's idea implemented.

If you wish I do not object.

Daniel
