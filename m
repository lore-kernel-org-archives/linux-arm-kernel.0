From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 24 Aug 2014 11:49:51 +0200
Subject: [PATCH v3 0/6] Migrate PXA27x platforms to clock framework
In-Reply-To: <1465795.XsPpj3dZHX@wuerfel> (Arnd Bergmann's message of "Sat, 23
 Aug 2014 20:54:38 +0200")
References: <1406753464-15000-1-git-send-email-robert.jarzmik@free.fr>
 <CAN1soZwDDwiLuVkT7kRJX-wy-UmyDj-2yiReGrpBrTOJkKpuSA@mail.gmail.com>
 <87ha1342ei.fsf@free.fr> <1465795.XsPpj3dZHX@wuerfel>
Message-ID: <87d2bq43pc.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> I didn't know we were supposed to merge it. There was no reason
> against merging it when you posted it, but you didn't make it clear
> what you want to happen.
Right.

> By default, I'd expect Haojian to pick up the patches and send
> us a pull request. He sent an Ack, but also didn't make it clear
> that we should pick them up.
I was thinking that they would go through the clk maintainers, hence Haojian's
ack. If they should go through arm-soc, they would need Mike's ack.

> If you want code to be merged directly through arm-soc, please
> send the pull request "To:" arm at kernel.org (with all interested
> parties the mailing lists in Cc) and ask us directly to pull it,
> to avoid all ambiguity.
OK, I can do it with Mike's ack first.

> Sometimes we can miss patches (as opposed to pull requests) since
> at least I tend to scan my inbox for the 'GIT PULL' keyword. If
> we don't seem to react within a week, just send a friendly reminder.
No problem, it's not as if this was a business critical platform :)

> For the specific case of PXA, I wonder if we should update the
> maintainer entry. As far as I can tell, Eric and Russell are no
> longer actively involved in the maintenance of PXA, and Haojian
> is doing only the bare minimum and is kept busy by other platforms
> these days (mach-hisi, mach-mmp). Should we perhaps add you and/or
> Daniel and remove some of the others if they are no longer as
> actively working on PXA?

Sure, I'll send a patch to add myself to the MAINTAINERS of pxa. Would be great
if Daniel stepped in too, as my pxa3xx knowledge is poor.

As to removing Russell and Eric, we should get their opinion, it's as they want,
I can send it in the maintainers patch if they agree.

Cheers.

-- 
Robert
