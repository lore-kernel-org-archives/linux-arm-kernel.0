From: khilman@linaro.org (Kevin Hilman)
Date: Mon,  9 Sep 2013 15:42:32 -0700
Subject: [GIT PULL 0/3] ARM: SoC: Second round of changes for v3.12
Message-ID: <1378766555-9679-1-git-send-email-khilman@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here's a 2nd round of changes from ARM SoC land.

The main thing of note (or of potential annoyance factor) here is the
handful of conflicts in PULL 2/3 coming from platform changes
conflicting with driver changes going in to the V4L tree.  I've listed
them in detail in that pull request, and we will work with the
platform maintainer on the workflow to avoid this in the future.

For future reference, when it comes to these conflicts, do you want to
see a summary of the suggested resolutions, a published branch with
the resolutions, both or neither?  Just curious.

Kevin
