From: holgerschurig@gmail.com (Holger Schurig)
Date: Tue, 19 Jan 2016 17:05:04 +0100
Subject: [LINUX PATCH 5/5] mmc: host: Update the quirks for this
 controller.
In-Reply-To: <1453213055-35563-5-git-send-email-lakshmis@xilinx.com> (P. L.
 Sai Krishna's message of "Tue, 19 Jan 2016 19:47:35 +0530")
References: <1453213055-35563-1-git-send-email-lakshmis@xilinx.com>
 <1453213055-35563-5-git-send-email-lakshmis@xilinx.com>
Message-ID: <87fuxt4ksv.fsf@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Don't write "of this controller" into subject, write "of sdhci-arasan"
or something like it.

Otherwise people will have to look into your patch description ...

> This patch adds SDHCI_QUIRK2_STOP_WITH_TC quirk to remove
> the following error message.
> "mmc0: Got data interrupt 0x00000002 even though no data
> operation was in progress"

But wait, it's not there, too. So people have to look into the patch
itself. :-(



Holger
