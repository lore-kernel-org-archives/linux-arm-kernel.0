From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 8 Jan 2011 02:52:33 +0530
Subject: [PATCH v2 2/5] omap2plus: prm: Trvial build break fix for
	undefined reference to 'omap2_prm_read_mod_reg'
In-Reply-To: <87r5comn6o.fsf@ti.com>
References: <1294225024-21857-1-git-send-email-santosh.shilimkar@ti.com><1294225024-21857-2-git-send-email-santosh.shilimkar@ti.com><alpine.DEB.2.00.1101061056340.22048@utopia.booyaka.com><e194160102cb8b695465c81eea6582fc@mail.gmail.com>
	<87r5comn6o.fsf@ti.com>
Message-ID: <d252887d2246f5e31e3763666ddc4958@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman at ti.com]
> Sent: Saturday, January 08, 2011 2:44 AM
> To: Santosh Shilimkar
> Cc: linux-omap at vger.kernel.org; tony at atomide.com; linux-arm-
> kernel at lists.infradead.org; Paul Walmsley
> Subject: Re: [PATCH v2 2/5] omap2plus: prm: Trvial build break fix
> for undefined reference to 'omap2_prm_read_mod_reg'
>
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
> [...]
>
> >> I think it would be best to use WARN() on these, rather than
> >> WARN_ONCE().  That's because these could be called from different
> >> parts of the code base, and the stack backtrace will help someone
> >> figure out all the code that needs to be fixed.
> >>
> >> Once you do that, this patch is
> >>
> >> Acked-by: Paul Walmsley <paul@pwsan.com>
> >>
>
> > With WARN() instead of WARN_ONCE() and Paul's ack, here
> > is an updated patch.
>
> Thanks, will queue for .38-rc cycle.
>
> I'll again plead for working on your git-send-email setup.  It looks
> like your using outlook.  The inline patch is wrapped (as outlook
> almost
> always does.)  The attached version applied fine, but the strong
> preference is for a single inline patch.
>
Its google mail now a days. I thought it will wrap and
hence attached the version.

Fully agree with inline patch but as this one was minor
update I skipped it.

Regards
Santosh
