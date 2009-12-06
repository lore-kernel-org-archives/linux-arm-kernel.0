From: dwalker@codeaurora.org (Daniel Walker)
Date: Sun, 06 Dec 2009 05:55:07 -0800
Subject: tree with htc dream support
In-Reply-To: <a55d774e0912051638u7858878cg7cf62905c3c005c1@mail.gmail.com>
References: <20091205221100.GA32522@elf.ucw.cz>
	<1260054737.23633.35.camel@desktop>
	<a55d774e0912051638u7858878cg7cf62905c3c005c1@mail.gmail.com>
Message-ID: <1260107707.23633.59.camel@desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2009-12-05 at 16:38 -0800, Brian Swetland wrote:
> On Sat, Dec 5, 2009 at 3:12 PM, Daniel Walker <dwalker@codeaurora.org>
> wrote:
>         https://www.codeaurora.org/gitweb/quic/kernel/?p=dwalker/linux-msm.git;a=shortlog;h=refs/heads/testing
>         
>         It's been in Linux-next for maybe two weeks .. I've been
>         trying to
>         decide if I should submit it for 2.6.33. I'm going to be
>         adding boat
>         loads of additional msm code and doing a fairly large merge
>         for
>         2.6.34 .. So your code would get better testing if we wait for
>         that.
>         
>         However, If you really want it in 2.6.33 I'll try to
>         accommodate you.
> 
> Arve's about to take our common and msm trees and rebase them over
> the .32, which may be useful for reference -- at least as a snapshot
> of a fully functional set of patches that android donut and eclair run
> on, on production hardware.  We'll make that available as soon as we
> have something that's bootable.

Ok .. I'm mainly working with a small subset of a full Android tree.
It's just isolated to the arch/arm/mach-msm/ directory (some in
arch/arm/) .. If you guys have changes to that area just let me know
where they are and I'll try to move them forward.

Daniel
