From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 2 Feb 2011 11:45:25 +0530
Subject: [PATCH 3/6] omap4: powerdomain: Use intended PWRSTS_* flags
	instead of values
In-Reply-To: <87aaifmdsg.fsf@ti.com>
References: <1296212688-21951-1-git-send-email-santosh.shilimkar@ti.com><1296212688-21951-4-git-send-email-santosh.shilimkar@ti.com>
	<87aaifmdsg.fsf@ti.com>
Message-ID: <5a0d09983b1cc3befe85acd85176e289@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman at ti.com]
> Sent: Wednesday, February 02, 2011 6:52 AM
> To: Santosh Shilimkar
> Cc: linux-omap at vger.kernel.org; paul at pwsan.com; b-cousson at ti.com;
> rnayak at ti.com; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 3/6] omap4: powerdomain: Use intended PWRSTS_*
> flags instead of values
>
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
> > IVAHD and ABE power domain logic state is populated using directly
> > value instead of the capability flags.
> >
> > Fix the same.
>
> Again, has this been fixed in the scripts?
>
> For future reference,  It will be helpful to note in the changelog
> that
> this kind of thing has been fixed in the autogen scripts.
>
The power domain scripts was out of sync with code.
And hence its not mentioned.
Benoit has merged the changes from Paul and we will
update this additional change on top of it

Regards,
Santosh
