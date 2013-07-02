From: dsd@laptop.org (Daniel Drake)
Date: Tue, 2 Jul 2013 08:26:22 -0600
Subject: [GIT PULL] Initial OLPC XO-1.75/XO-4 support
In-Reply-To: <20130702045304.GA27829@quad.lixom.net>
References: <20130702031244.B2D74FAAD2@dev.laptop.org>
 <20130702045304.GA27829@quad.lixom.net>
Message-ID: <CAMLZHHQu_UUQvT1db7hL2XYX=EzwNaGjyeTuZkwfYHJmG5BUdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 1, 2013 at 10:53 PM, Olof Johansson <olof@lixom.net> wrote:
> 1) Please post the drivers/clk patches to mturquette. THey don't look dependent
>    on the rest of the patches, just general improvements and cleanups.
> 2) I really wish there was a generic catch-all compat for the boards, so we
>    didn't have to modify mmp2-dt.c for every new board added -- it really
>    defies the purpose of only changing the data you pass into the kernel. This
>    is mostly something for Eric/Haojian to sort out though.
> 3) Please post the patches as a series instead of a pull request, given that
>    they should probably take different paths up the tree (clk vs the platform,
>    etc). You should at least get review/acked-by of the clk pieces from Mike
>    Turquette.

Thanks for the suggestions. I have already posted the patches as
emails a little more than 2 weeks ago, including sending the clock
ones to Mike. I will resend next week if they are still pending, when
the maintainers might be a bit less busy.

cheers
Daniel
