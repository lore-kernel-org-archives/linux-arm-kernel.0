From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 26 May 2017 01:23:17 +0200
Subject: [PATCH v2] arm: eBPF JIT compiler
In-Reply-To: <1495754003-21099-1-git-send-email-illusionist.neo@gmail.com>
References: <1495754003-21099-1-git-send-email-illusionist.neo@gmail.com>
Message-ID: <20170525232317.GA30485@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Tested on ARMv7 with QEMU by me (Shubham Bansal).
> Tested on ARMv5 by Andrew Lunn (andrew at lunn.ch).
> Expected to work on ARMv6 as well, as its a part ARMv7 and part ARMv5.
> Although, a proper testing is not done for ARMv6.
> 
> Both of these testing are done with and without CONFIG_FRAME_POINTER
> separately for LITTLE ENDIAN machine.

Nope. I only tested it in the default configuration of mvebu_v5_defconfig.
Please change the 'Both' to 'Some'.

      Andrew
