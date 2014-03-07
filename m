From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 7 Mar 2014 11:55:45 -0500
Subject: [GIT PULL] ARM: mvebu: driver changes for v3.15 (incr. #2)
Message-ID: <20140307165545.GF18707@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

Nothing big here.  This is the last pull for mvebu/drivers for v3.15.
As usual, this is an incremental pull request from
tags/mvebu-drivers-3.15 in the mvebu/drivers branch up to
tags/mvebu-drivers-3.15-2.

After a week of silence, I let the power maintainers know that I'd like
to take this and to speak up if that wasn't ok.  It's been a week since.
This is also very isolated, so there shouldn't be any merge conflicts.

Please pull.

thx,

Jason.

The following changes since commit ff1f0018cf66080d8e6f59791e552615648a033a:

  drivers: Enable building of Kirkwood drivers for mach-mvebu (2014-02-24 17:28:31 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-drivers-3.15-2

for you to fetch changes up to 200c0a3e404beab02be83e5cbf111d26b9f6ce22:

  Power: Reset: Generalize qnap-poweroff to work on Synology devices. (2014-03-04 03:48:41 +0000)

----------------------------------------------------------------
mvebu driver changes for v3.15 (incremental pull #2)

 - reset
    - re-use qnap-poweroff driver for Synology NASs

----------------------------------------------------------------
Andrew Lunn (1):
      Power: Reset: Generalize qnap-poweroff to work on Synology devices.

 .../bindings/power_supply/qnap-poweroff.txt        |  5 ++-
 drivers/power/reset/qnap-poweroff.c                | 49 ++++++++++++++++------
 2 files changed, 41 insertions(+), 13 deletions(-)
