From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 23 Jan 2013 19:03:52 +0100
Subject: [PATCH v2 2/3] arm: mvebu: Enable USB controllers on Armada
 370/XP boards
In-Reply-To: <CALF0-+XJEXJ2B3NLu5DvyxaDuuMNP=zk+z8QUd4GTQULW3BpyA@mail.gmail.com>
References: <1358954792-16160-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1358954792-16160-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <CALF0-+XJEXJ2B3NLu5DvyxaDuuMNP=zk+z8QUd4GTQULW3BpyA@mail.gmail.com>
Message-ID: <20130123190352.2d001218@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ezequiel Garcia,

On Wed, 23 Jan 2013 14:04:42 -0300, Ezequiel Garcia wrote:

> from the OpenBlocks AX3-4 board dts file, since you mentioned this
> board uses that USB
> port for a PCIe connector -- if I understood correctly.

No. The OpenBlocks has a different USB controller that sits on the PCIe
bus. There is nothing like a PCIe port that uses a USB port, that
doesn't make sense.

> So, IMHO, if OpenBlocks uses third USB port to connect some PCIe
> controller, we should activate it in the dts file.
> 
> What do you think?

No, see above.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
