From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Thu, 11 Feb 2016 16:29:20 +0000
Subject: [PATCH v2 0/7] ARM/efi minor fixes + stub pre-boot compat checks
In-Reply-To: <CAKv+Gu-kZrcLYhF7i0u8F2TOMqEVKp==jNoBc+Rfk61cwSkDhQ@mail.gmail.com>
References: <1454601030-9093-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160211161621.GM4134@codeblueprint.co.uk>
 <CAKv+Gu-kZrcLYhF7i0u8F2TOMqEVKp==jNoBc+Rfk61cwSkDhQ@mail.gmail.com>
Message-ID: <20160211162920.GN4134@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 11 Feb, at 05:18:12PM, Ard Biesheuvel wrote:
> On 11 February 2016 at 17:16, Matt Fleming <matt@codeblueprint.co.uk> wrote:
> > On Thu, 04 Feb, at 04:50:23PM, Ard Biesheuvel wrote:
> >> I merged two EFI/ARM related series, whose v1's I sent out last week:
> >>
> >> Changes since v1:
> >> - added various tags from various people
> >> - new patch #3 to undefine __init
> >>
> >> @Matt: are you happy with all of this going through the arm64 tree? I don't
> >> think it clashes with anything else we've got queued up for v4.6 in tip/efi/core
> >
> > How come this is going through the arm64 tree? Are there other patch
> > series that this depends on or that depend on it?
> >
> > If it makes the most sense to take it through that tree, then I'm fine
> > with it but I'd like to hear a rationale.
> 
> I simply thought it would be most convenient, since it touches
> ARM-specific files only. But if you feel it should go via the EFI tree
> instead, that is also fine by me.

Since the diff stat is heavily weighted towards drivers/firmware/efi I
think it should go via the EFI tree. So I'll pick this up (the changes
look fine) unless Will or Catalin complain otherwise.

I'm also keen to allay any concerns that the EFI tree is somehow
x86-specific.
