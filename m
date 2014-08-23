From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 23 Aug 2014 20:54:38 +0200
Subject: [PATCH v3 0/6] Migrate PXA27x platforms to clock framework
In-Reply-To: <87ha1342ei.fsf@free.fr>
References: <1406753464-15000-1-git-send-email-robert.jarzmik@free.fr>
 <CAN1soZwDDwiLuVkT7kRJX-wy-UmyDj-2yiReGrpBrTOJkKpuSA@mail.gmail.com>
 <87ha1342ei.fsf@free.fr>
Message-ID: <1465795.XsPpj3dZHX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 23 August 2014 18:05:41 Robert Jarzmik wrote:
> Haojian Zhuang <haojian.zhuang@gmail.com> writes:
> > Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
> >
> > Only with a small comment.
> >
> > Regards
> > Haojian
> Hi Mike and Arnd,
> 
> I suppose this patchset didn't make it to 3.17 timeframe, right ?
> And I don't see it scheduled either for linux-next.
> 
> Is there something blocking it ?

I didn't know we were supposed to merge it. There was no reason
against merging it when you posted it, but you didn't make it clear
what you want to happen.

By default, I'd expect Haojian to pick up the patches and send
us a pull request. He sent an Ack, but also didn't make it clear
that we should pick them up.

If you want code to be merged directly through arm-soc, please
send the pull request "To:" arm at kernel.org (with all interested
parties the mailing lists in Cc) and ask us directly to pull it,
to avoid all ambiguity.

Sometimes we can miss patches (as opposed to pull requests) since
at least I tend to scan my inbox for the 'GIT PULL' keyword. If
we don't seem to react within a week, just send a friendly reminder.

For the specific case of PXA, I wonder if we should update the
maintainer entry. As far as I can tell, Eric and Russell are no
longer actively involved in the maintenance of PXA, and Haojian
is doing only the bare minimum and is kept busy by other platforms
these days (mach-hisi, mach-mmp). Should we perhaps add you and/or
Daniel and remove some of the others if they are no longer as
actively working on PXA?

	Arnd
