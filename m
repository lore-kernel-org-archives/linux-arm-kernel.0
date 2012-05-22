From: olof@lixom.net (Olof Johansson)
Date: Mon, 21 May 2012 22:35:00 -0700
Subject: [GIT PULL 0/8] First batch of arm-soc branches for 3.5
Message-ID: <1337664908-17478-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

These are the first 8 pull requests for arm-soc for the 3.5 merge window,
containing roughly half of our queued up changes.

Descriptions of each branch are in the corresponding request.

A few things to note:

* For reference I have pushed a merge-resolved branch against 47136855
  for every tag, to be found at resolved/<tagname>.

* There will be a conflict with the staging tree in two of the at91
  device tree files (at91sam9260.dtsi and at91sam9g20.dtsi). The
  version in arm-soc is the correct one (see
  http://marc.info/?l=linux-arm-kernel&m=133734654114734&w=2 for history).

* If you pull the staging tree before the 4th branch (device tree
  conversions), please also be aware of an automatic merge resolution error
  discovered in -next (see pull request for details, same thread as above).

* The 4th branch (device tree conversions) contains 4 patches that is
  also going through the embedded i2c tree. Wolfram agreed earlier that
  we could merge these through arm-soc so they are included here.


Thanks!

-Olof
