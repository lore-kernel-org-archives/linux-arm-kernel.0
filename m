From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Fri, 06 Dec 2013 18:48:10 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSHY3XVsgMi8yXSB2aWRlbzogYmFja2xpZ2h0OiBncGlvLWJh?=
 =?UTF-8?B?Y2tsaWdodDogQWRkIERUIHN1cHBvcnQu?=
In-Reply-To: <20131206141236.GA32313@ulmo.nvidia.com>
References: <1386266109-16071-1-git-send-email-denis@eukrea.com>
 <1386335318.12471946@f258.i.mail.ru>
 <20131206141236.GA32313@ulmo.nvidia.com>
Message-ID: <1386341290.792909778@f66.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Fri, Dec 06, 2013 at 05:08:38PM +0400, Alexander Shiyan wrote:
> > > On Thu, Dec 05, 2013 at 06:55:09PM +0100, Denis Carikli wrote:
> > > [...]
> > > > +Optional properties:
> > > > +  - default-state: The initial state of the backlight.
> > > > +    Valid values are "on", "off", and "keep".
> > > > +    The "keep" setting will keep the backlight at whatever its current
> > > > +    state is, without producing a glitch. The default is keep if this
> > > > +    property is not present.
> > > 
> > > I'm not sure if "on", "off" and "keep" are a good choice for this
> > > binding. Having strings for these tristate values seems suboptimal.
> > > Other bindings have chosen a representation that, transposed to this
> > > use-case, would read something like this:
> > > 
> > > 	- default-state: The initial state of the backlight. Valid
> > > 	  values:
> > > 	  - 0: off
> > > 	  - 1: on
> > > 
> > > 	If the "default-state" property is not present, the default
> > > 	will be to keep the current backlight state.
> > > 
> > > Which is in fact the exact behaviour that your binding describes, but
> > > it's much more intuitive in my opinion.
> > 
> > Why we cannot use GPIO bindings for active level here?
> > What a reason for "keep" state? Can this be an additional property?
> 
> Default state and active level are two different things.

OK. And what is "default" state? State before "unblank"?

---
