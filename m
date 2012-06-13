From: josh.coombs@gmail.com (Josh Coombs)
Date: Wed, 13 Jun 2012 14:27:25 -0400
Subject: Converting kirkwood-goflexnet to DTS
Message-ID: <CAMW5Ufar3+RFwwmPd5xS_aNBKz6VLyDnw_3_aJDOR-xRz1kkTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have a functional Seagate GoFlex Net running 3.4.2 using a patched
in mach-kirkwood board definition from the Archlinux ARM port.  Based
on my reading it appears the way to move forward is to build a DTS
file for the device and once stable, it might be possible to get it
supported directly by the mainline kernel for a change.

It looks like Kirkwoods are currently getting some DTS attention, I'm
slowly trying to bootstrap myself on the format.  I have a working
board file and a working appliance to test on.  Are there any pointers
or docs I can review to try and make an initial try at lighting this
device via a DTS based kernel?

Joshua Coombs
