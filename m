From: dbrignoli@audioscience.com (Delio Brignoli)
Date: Thu, 5 Nov 2015 14:08:52 +0100
Subject: Minimal support for dm814x
Message-ID: <4999BB3D-4BB5-4F7C-96D7-FB687725CDCC@audioscience.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Tony,

We use dm814x in some of our products with a kernel based on version 2.6.37 modified by TI and are considering moving to a current kernel version. I recently saw this <http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/348444.html> and I?d like to try getting our board to boot as a first step and then take it from there.
We aim at eventually having remoteproc working (at least for the DSP) and to port fixes/features we added to our 2.6.37 based tree [2].

The temporary testing branch [1] mentioned in your original message is not longer available, does that mean I can just use the master branch of <https://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git> for my tests? Which toolchain did you use to build your test kernel for the hp t410?

I wonder if there is anyone on this list already working on getting dm814x fully working or interested in cooperating towards this goal.

Thank you!
--
Delio

[1] <https://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/log/?h=tmp-testing-dm814x-2015-06-03>
[2] <https://github.com/audioscience/linux-omap3/tree/asi1230-upstream-tracking>
