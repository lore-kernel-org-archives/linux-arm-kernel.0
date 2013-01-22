From: matt@genesi-usa.com (Matt Sealey)
Date: Mon, 21 Jan 2013 18:26:14 -0600
Subject: One of these things (CONFIG_HZ) is not like the others..
In-Reply-To: <CAKGA1bk-K=D6EDBfJ7LggpTroj1sFC8VStctqGi=NacLEu95cA@mail.gmail.com>
References: <CAKGA1bkiowcO7OPSfPmaB6eRj_3FNr+4ONnaQHEZkpxB2XfduQ@mail.gmail.com>
 <201301212041.17951.arnd@arndb.de> <50FDAC5F.4040605@linaro.org>
 <20130121211218.GX23505@n2100.arm.linux.org.uk>
 <CAKGA1bkZ4sN_eXAk1nUzvGE6cvvQ+b+jnTezTM863qFNL8NqWg@mail.gmail.com>
 <20130121224252.GY23505@n2100.arm.linux.org.uk>
 <CAKGA1b=AG_a=KCi6qoeoRoG+5bcYkn3gAVb4S2dbaFzu4ioJdQ@mail.gmail.com>
 <20130121234908.GD23505@n2100.arm.linux.org.uk>
 <CAKGA1bk-K=D6EDBfJ7LggpTroj1sFC8VStctqGi=NacLEu95cA@mail.gmail.com>
Message-ID: <CAKGA1bndiQkVSFh=Fpk8WjLe4L_EFyRa1mHyVUF9PFine-Wpcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 6:09 PM, Matt Sealey <matt@genesi-usa.com> wrote:

[LAKML: about lack of SCHED_HRTICK because we don't use
kernel/Kconfig.hz on ARM)]

> kind of leaves ARM in the doghouse.. who knows what weirdo scheduler
> reactions are related to it not being enabled. Maybe when it is, HZ
> *would* need to be allowed to be bumped when using this code path?

Or conversely maybe this is exactly why the Samsung maintainers
decided they need HZ=200, because SCHED_HRTICK isn't being enabled and
they're experiencing some multimedia lag because of it?

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
