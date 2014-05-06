From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 6 May 2014 16:14:11 +0100
Subject: [PATCH resend 01/15] asm-generic: allow generic unaligned access
 if the arch supports it
In-Reply-To: <CAKv+Gu_YAd=0gsB=XG0syR+aEJerunvr_SQKtMopMPr5WOQ66w@mail.gmail.com>
References: <1398959381-8126-1-git-send-email-ard.biesheuvel@linaro.org>
 <1398959381-8126-2-git-send-email-ard.biesheuvel@linaro.org>
 <20140506143120.GD23957@arm.com>
 <CAKv+Gu_YAd=0gsB=XG0syR+aEJerunvr_SQKtMopMPr5WOQ66w@mail.gmail.com>
Message-ID: <20140506151410.GG23957@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 06, 2014 at 03:34:23PM +0100, Ard Biesheuvel wrote:
> On 6 May 2014 16:31, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Thu, May 01, 2014 at 04:49:33PM +0100, Ard Biesheuvel wrote:
> >> Switch the default unaligned access method to 'hardware implemented'
> >> if HAVE_EFFICIENT_UNALIGNED_ACCESS is set.
> >>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> Acked-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >>  include/asm-generic/unaligned.h | 21 +++++++++++++--------
> >>  1 file changed, 13 insertions(+), 8 deletions(-)
> >
> > I'm happy to take this patch via the arm64 tree. But arm is affected as
> > well, so it would be good to know if Russell has any objections (cc'ed).
> >
> > Patch below for reference. Thanks.
> >
> 
> Russell has already replied to that:
> http://marc.info/?l=linux-arm-kernel&m=139696976302889&w=2

Thanks.

-- 
Catalin
