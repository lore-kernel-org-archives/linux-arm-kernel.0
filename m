From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 06 Jul 2013 01:41:02 +0200
Subject: [PATCH] drm/exynos: Add missing includes
In-Reply-To: <20130702150449.GO27646@sirena.org.uk>
References: <1372683355-27460-1-git-send-email-broonie@kernel.org>
 <008a01ce771e$afe02670$0fa07350$%dae@samsung.com>
 <20130702150449.GO27646@sirena.org.uk>
Message-ID: <1504355.0ZFzGzMgKd@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 of July 2013 16:04:49 Mark Brown wrote:
> On Tue, Jul 02, 2013 at 09:21:32PM +0900, Inki Dae wrote:
> > > Ensure that all externally accessed functions are correctly
> > > prototyped
> > > when defined in each file by making sure the headers with the
> > > protoypes
> > > are included in the file with the definition.
> > 
> > I don't see why this patch is needed. it seems like including
> > unnecessary headers so it makes the code size enlarged.
> 
> Well, aside from it being basic good practice and allowing the compiler
> to check for errors in the prototypes this is also something that sparse
> warns about.
> 
> If the resulting binary size is changed by having the headers included
> then that indicates a bug in the headers - they *really* shouldn't be
> doing anything substantial here.  None of the headers in question looked
> at all worrying.

+1

Best regards,
Tomasz
