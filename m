From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 18 Nov 2015 14:41:10 +0000
Subject: AMLogic Meson serial driver fixes
Message-ID: <1447857679-30158-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Whilst testing the 4.3 kernel on an AMlogic AM805 (Odroid-C1) with
a systemd based system, the console has issues with missing parts
of the output.

This is a set of fixes, and a few cleanups which makes the output
when the console is set to ttyAML0 usable.
