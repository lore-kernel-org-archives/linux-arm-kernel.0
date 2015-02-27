From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sat, 28 Feb 2015 00:04:04 +0100
Subject: [PATCH] genirq: better describe IRQF_NO_SUSPEND semantics
In-Reply-To: <20150227152313.7247ed2c@lwn.net>
References: <1424444026-31231-1-git-send-email-mark.rutland@arm.com>
 <1425092792.1YLq228Omk@vostro.rjw.lan> <20150227152313.7247ed2c@lwn.net>
Message-ID: <1861422.rtsUbbsKiF@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, February 27, 2015 03:23:13 PM Jonathan Corbet wrote:
> On Fri, 27 Feb 2015 23:41:05 +0100
> "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> 
> > > Applied (with Peter's ack) to the docs tree.  
> > 
> > Well, I've applied it too in the meantime. :-)
> > 
> > Also I'll have more commits on top of it, so it's better if it goes through
> > my tree I think, if you don't mind.
> 
> Gee, I feel like I've been here before :)
> 
> In the future, would you like me to avoid taking patches to
> Documentation/power?

Well, I tend to apply them as a rule, unless I overlook them.  That usually
happens if they aren't CCed to me directly or to linux-pm.

But yeah, you can safely avoid patches touching Documentation/power/ or
Documentation/acpi/, I'll be taking care of them.

> I'll drop it out of my tree.

Thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
