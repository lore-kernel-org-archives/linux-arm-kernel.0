From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Thu, 15 Oct 2009 11:42:54 +0200
Subject: [RFC] mx31moboard: patches for next merge window
Message-ID: <1255599780-12948-1-git-send-email-valentin.longchamp@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are the patches I would like to push during the next merge window for
the mx31moboard platform.

It consists of a fix for a small hardware design issue for the main serial
port, a few GPIOs used on the robots that are declared, camera support and
finally MC13783 support as it is now getting ready.

For MC13783, we would need RTC as well, but I did not add it yet since it
is not in mainline yet.

The camera part still is initial: it works well with a single camera but I
still have to figure out what is the best way to handle the two mt9t031 we
have on the marxbot.

The main peripheral that we are using and that still is missing is the USB
host, but since the driver still needs a few improvements, I keep it aside
for now.

Please review and comment.

Val
