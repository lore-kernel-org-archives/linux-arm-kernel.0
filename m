From: slash.tmp@free.fr (Mason)
Date: Thu, 5 Nov 2015 12:02:33 +0100
Subject: Grafting old platform drivers onto a new DT kernel
Message-ID: <563B3749.50701@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

My company provides a 3.4 kernel for an ARM-based SoC (there's also a 2.6.32
stashed somewhere for customers refusing to upgrade) along with drivers of
dubious quality written over the past decade.

I was tasked to release a new kernel, and took the opportunity to perform
a massive clean-up by discarding everything, and adding only enough code
on top of a recent kernel to boot to the shell.

I now have a small port with no drivers.
(I do have working serial and ethernet.)

Since I don't have time to rewrite the drivers at the moment, I'm wondering
if it's possible to "graft" old drivers (they're using the platform API, no
trace of DT support) onto my small base?

That way I can make management happy by providing a working new kernel,
and I can start working on converting drivers one-by-one.

Is that a realistic plan? What traps am I likely to fall into?

Regards.
