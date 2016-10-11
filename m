From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 11 Oct 2016 16:10:58 +0100
Subject: [PATCH] arm64: mmu: set the contiguous for kernel mappings when
 appropriate
In-Reply-To: <CAKv+Gu_y126PuYhmTq81Psjs6Ss_g2zTYm9asqPDBpc5Uqvh0Q@mail.gmail.com>
References: <1476123164-10532-1-git-send-email-ard.biesheuvel@linaro.org>
 <20161011074419.GA20213@remoulade>
 <CAKv+Gu_y126PuYhmTq81Psjs6Ss_g2zTYm9asqPDBpc5Uqvh0Q@mail.gmail.com>
Message-ID: <20161011151058.GB25865@remoulade>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2016 at 09:21:14AM +0100, Ard Biesheuvel wrote:
> On 11 October 2016 at 08:44, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Mon, Oct 10, 2016 at 07:12:44PM +0100, Ard Biesheuvel wrote:
> > Not a big deal, but the 'block' part here and elsewhere is now arguably
> > misleading (given 'block' is an architectural term).
> >
> > I haven't come up with a better term, so again, not a big deal. ;)
> 
> Indeed. I could simply call it 'allow_cont_mappings' in the context of
> this function, and keep the call below as is.

I'd prefer that the naming is consistent across functions, even if it's left
as-is (and arguably cont makes it sounds like it doesn't cover block mappings).
So unless we find a suitably-equipped thesaurus, as-is is probably fine.

Thanks,
Mark.
