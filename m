From: carlo@caione.org (Carlo Caione)
Date: Fri, 3 Oct 2014 09:52:13 +0200
Subject: [PATCH 0/3] ARM: Meson6: enable SMP
In-Reply-To: <20141003070913.GH4039@lukather>
References: <1412066635-5298-1-git-send-email-carlo@caione.org>
 <3274534.jCjlMt5HJV@wuerfel> <20141002153804.GF4039@lukather>
 <1867489.B8srtuItsD@wuerfel> <20141003070913.GH4039@lukather>
Message-ID: <CAOQ7t2a9maPeOsBmtvAwn1f5t_YunwRdOPZveF0pD0B_3ZqbbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 3, 2014 at 9:09 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
>> mach-meson is still in a very early stage, and it's not like SMP support
>> is the most important feature missing from it. If there are good reasons
>> to include the current patches in 3.19, we can do that.
>
> That's more of a mainlining scheduling discussion, and I can't really
> argue with that. I wouldn't have done it in that order, but I'm not
> really sure we can do that on that argument alone.

The SMP support was implemented because it was fairly small and fun
enough to write during my breaks from working on the clock drivers. I
work on mainlining during the nights after my daily job, so yeah, I
don't really have a mainlining schedule (yet) :)

> The only question that should matter I guess is whether this feature
> improves the overall support of the SoC, and whether the code is clean
> enough. If both answers are yes, then I think it should come in.

Agree

> Remember that Carlo is a hobbyist, and doesn't really have an agenda
> :)

But wait, if someone is willing to offer me a job to work full-time on
the Linux kernel this could easily change ;)

Cheers,

-- 
Carlo Caione
