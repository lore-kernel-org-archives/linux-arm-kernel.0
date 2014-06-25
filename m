From: will.deacon@arm.com (Will Deacon)
Date: Wed, 25 Jun 2014 09:38:23 +0100
Subject: [PATCHv3] arm64: Add CONFIG_CC_STACKPROTECTOR
In-Reply-To: <CAGXu5jLTLU-azWtyfJ38QO_vd9T+F4STqPy4LpvOeMAqPCH21A@mail.gmail.com>
References: <1391115944-10183-1-git-send-email-lauraa@codeaurora.org>
 <CAGXu5jKmrpM=oCABXy-UJH6mZ22Z2r-p_R2nZKqGocHJ0vYQ2Q@mail.gmail.com>
 <CAGXu5jLTLU-azWtyfJ38QO_vd9T+F4STqPy4LpvOeMAqPCH21A@mail.gmail.com>
Message-ID: <20140625083823.GB6153@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 01:24:05AM +0100, Kees Cook wrote:
> On Fri, Jan 31, 2014 at 2:50 PM, Kees Cook <keescook@chromium.org> wrote:
> > On Thu, Jan 30, 2014 at 1:05 PM, Laura Abbott <lauraa@codeaurora.org> wrote:
> >> arm64 currently lacks support for -fstack-protector. Add
> >> similar functionality to arm to detect stack corruption.
> >>
> >> Cc: Will Deacon <will.deacon@arm.com>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> >
> > Thanks!
> >
> > Acked-by: Kees Cook <keescook@chromium.org>
> 
> Hi again,
> 
> This patch never got applied any where. Who can take this?

We can take this via the arm64 tree. Laura, is the patch still valid against
current mainline?

Will
