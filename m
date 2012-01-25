From: matt@genesi-usa.com (Matt Sealey)
Date: Tue, 24 Jan 2012 19:54:08 -0600
Subject: Common clock API for i.MX
Message-ID: <CAKGA1bkHgnJQs3_n6QtQjf-8xaPn0YnxMmE2Q=+opWcsp10zQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd/RMK/Sascha,

We're trying to bring up a good batch of drivers here for MX51 and
EfikaMX systems and noticed that the released 3.2 kernel doesn't
include the common clock stuff that all the other platforms seem to be
using. In order to get things tested on a stable kernel before we leap
ahead, especially for Sascha's IPU code and in general platform
independence for any code using the clock API (by that I mean I don't
want to have to hack #include <mach/clock.h> in anything if I can help
it) I kind of need the newbies guide to where the clock code
tree/branch actually lives and more specifically is there a minimal
patchset I should be looking at rather than merging down a development
tree on top of our kernel?

The last discussion I saw on this was April last year, and now things
are moving to mach-imx this is starting to get a little complicated,
there's a lot of disjointed history to walk through. Any advise on
what to do and where to look would be invaluable. Is the patchset from
April (which starts here from the cleanest tree I can find;
http://git.pengutronix.de/?p=imx/linux-2.6.git;a=commit;h=32c99207d4231ae4f807866b29bbfd0415087400)
still valid or is there somewhere better I should be looking?

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
