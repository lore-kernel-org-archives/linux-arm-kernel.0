From: olof@lixom.net (Olof Johansson)
Date: Mon, 31 Aug 2015 17:07:03 -0700
Subject: [GIT PULL 0/7] ARM: SoC changes for v4.3
Message-ID: <1441066030-23225-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here's the main batch of changes from arm-soc for 4.3. Besides this we
also have a branch of changes that looked to be late-arriving (right
before -rc7), and we'll leave those to a separate pull request a little
later.

Nothing in here should be controversial at this point. We have more
external dependencies than we've had for a while, mostly with the clk
tree.  We also picked up some other misc drivers with appropriate acks
(rtc, pci, etc) through the platform maintainers the drivers are for.

We've been able to keep conflicts down this cycle, only a few and none
are hairy. I've described them in the affected pull requests.

There's a branch "armsoc-resolved" available with my version of the
resolutions.

Please merge!


Thanks,

-Olof
