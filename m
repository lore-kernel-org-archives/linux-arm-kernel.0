From: khilman@ti.com (Kevin Hilman)
Date: Fri, 02 Sep 2011 11:06:52 -0700
Subject: testing-board branch: rebase to RMK's devel-stable?
Message-ID: <87vcta7r9f.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

Your testing-board branch currently has a couple new boards that are
missing the boot_params to atag_offset conversion (patch below.)

There's a patch below to fix this, but maybe it's better to just rebase
your testing-board branch onto Russell's devel-stable branch (where he's
merged the seris from Nico) so any board stuff we add is sure to do it
correctly.

Kevin
