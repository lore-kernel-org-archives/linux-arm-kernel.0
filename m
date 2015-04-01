From: Dave.Martin@arm.com (Dave Martin)
Date: Wed,  1 Apr 2015 12:05:40 +0100
Subject: [PATCH REPOST v4 0/2] serial/amba-pl011: Refactor and simplify TX
 FIFO handling
Message-ID: <1427886345-8507-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patches are based on
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next

This is a repost to add Jakub's S-o-B only.

There is no code change compared with v3.


Note that I'll be mostly offline for a week or so from tomorrow.

Andre depends on this series for his SBSA UART stuff, so I recommend
to coordinate with him if there are still issues that need to be
resolved in the meantime.  There are no outstanding issues that I'm
aware of.

Thanks
---Dave

Dave Martin (2):
  Revert "serial/amba-pl011: Leave the TX IRQ alone when the UART is
    not open"
  serial/amba-pl011: Refactor and simplify TX FIFO handling

 drivers/tty/serial/amba-pl011.c |  118 +++++++++------------------------------
 1 file changed, 27 insertions(+), 91 deletions(-)

-- 
1.7.10.4
