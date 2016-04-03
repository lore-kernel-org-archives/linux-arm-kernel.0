From: carlo@caione.org (Carlo Caione)
Date: Sun, 3 Apr 2016 19:34:18 +0200
Subject: [PATCH] ARM64: dts: amlogic: Add hiu and periphs buses
In-Reply-To: <5701508B.1050403@suse.de>
References: <1459703681-8689-1-git-send-email-carlo@caione.org>
 <5701508B.1050403@suse.de>
Message-ID: <CAOQ7t2Yh7ZOw13Mjj5NLupti7_WyGZ7LEPe_mhQXtUyTGtH3ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 3, 2016 at 7:19 PM, Andreas F?rber <afaerber@suse.de> wrote:
> Am 03.04.2016 um 19:14 schrieb Carlo Caione:
>
> Looks sane, but where did you get that info from? The others I had found
> in an iomap node or so but did not spot these.

For hiubus you can see the io_hiubus_base node in the gxbb_p201.dts DT file.
For the periphs bus is a bit more tricky. The only reasonable
information I found is oddly in
drivers/amlogic/hdmi/hdmi_tx_20/hw/reg_ops.c.

-- 
Carlo Caione
