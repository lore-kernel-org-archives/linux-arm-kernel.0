From: olof@lixom.net (Olof Johansson)
Date: Thu, 21 Nov 2013 10:06:42 -0800
Subject: Patches from ARM folks solicited for the -stable tree
In-Reply-To: <alpine.DEB.2.02.1311210442560.30143@utopia.booyaka.com>
References: <alpine.DEB.2.02.1311210442560.30143@utopia.booyaka.com>
Message-ID: <CAOesGMgKPxRQk_XWpGcCWzi_fw3wSWUnXCXo-eF4JZ21-30HZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

First, let's make sure linux-arm-kernel is cc:d on the
platform-maintainers emails. I meant it mostly to be used as a cc list
for extra attention to avoid having to find things on LAKML, not as a
standalone list.

On Wed, Nov 20, 2013 at 8:43 PM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Talking with Greg KH last month, he mentioned that the -stable maintainers
> aren't seeing enough patches from ARM SoC folks.  I'd assume this includes
> both subarchitecture and driver code.  So maybe this is something we can
> all change?
>
> The stable kernel submission information is available here:
>
>    https://www.kernel.org/doc/Documentation/stable_kernel_rules.txt
>
> These days it seems like I have about one patch per merge window that
> could be a stable candidate.

Thanks for bringing this up.

That does seem low, and we should be more mindful of it. I'm not
giving excuses but I think there are a few contributing factors to it:

1) We've had people work on new functionality more than anything, so
regressions don't really apply there, thus fewer stable fixes

2) Of the major platforms, very few actual products ship based on
mainline, so the feedback loop for fixes is veeery long (or
nonexistent). Most android platforms ship with substantially different
kernel trees and drivers, which means that whatever bugs they fix
don't apply to our versions (and would never find a way from -stable
into their product trees) :(

3) We've got fewer people relying on the older release (see above), in
the sense that we've so far had quite few distros ship kernels.

All three of the above should slowly be changing to the opposite,
which should also mean more stable patches. I'm looking forward to
that.


-Olof
