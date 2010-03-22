From: christofferdall@christofferdall.dk (Christoffer Dall)
Date: Sun, 21 Mar 2010 21:06:02 -0400
Subject: [C/R ARM][PATCH 0/3] Linux Checkpoint-Restart - ARM port
Message-ID: <1269219965-23923-1-git-send-email-christofferdall@christofferdall.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following there will be two preparatory patches for an ARM port of the
checkpoint-restart code and finally a third patch implementing the
architecture-specific parts of c/r.

The preparatory patches consist of a systrace implementation for ARM
based on a previous patch from Roland McGrath and an eclone implementation
for ARM. The systrace implementation is partial and provides the needed
functionality for c/r.

There is a separate patch for the user space code, which supports
cross-compilation, extracting headers for ARM and an eclone implementation
for ARM.

The kernel patches presented here are based on the ckpt-v20 patch set.

Signed-off-by: Christoffer Dall <christofferdall@christofferdall.dk>
Acked-by: Oren Laadan <orenl@cs.columbia.edu>
