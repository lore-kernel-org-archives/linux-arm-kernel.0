From: olof@lixom.net (Olof Johansson)
Date: Tue, 17 Feb 2015 00:33:21 -0800
Subject: [GIT PULL 0/7] ARM: SoC changes for 3.20
Message-ID: <1424162008-23768-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

A little later than usual due to travel for both me and Arnd this merge
window, here are the arm-soc pull requests.

Like the kernel as a whole we seem to have a fairly small queue this time
around, with the smallest number of patches we've seen in a while. Our
for-next has only about 600 non-merge changes in it.

The cleanups this time around are quite nice, with 8100 lines removed from
arch/arm due to various stale code removals in the ones who were isolated
out, even more if code that was included in the SoC branch is counted.

We have several new platforms this time around. We have 3 new 64-bit
SoCs that mostly add DT contents and a few Kconfig entries, and 3 new
32-bit platforms with mostly the usual boilerplate code. In addition to
this, there are several new SoCs with just added DT contents.

We have two more incoming SoCs that were posted but I didn't apply
in time before the merge window. They are quite well contained, so I
_might_ still send them in a late pull request towards the end of the
merge window if things have been uneventful.


As usual, I've described the conflicts per pull request. Nothing was
particularly messy this time around, so I didn't bother pushing up a
resolved version for reference.


Please merge.


Thanks,


-Olof
