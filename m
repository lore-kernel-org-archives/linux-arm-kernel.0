From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 14 Apr 2011 15:02:01 +0400
Subject: [PATCH] Fixed gpio polarity of gpio USB-phy reset.
In-Reply-To: <1302766303-1157-1-git-send-email-J.Kilb@phytec.de>
References: <1302766303-1157-1-git-send-email-J.Kilb@phytec.de>
Message-ID: <4DA6D429.3000801@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 14-04-2011 11:31, Juergen Kilb wrote:

> With commit 19403165 a main part of ehci-omap.c moved to
> drivers/mfd/omap-usb-host.c created by commit 17cdd29d.

    Pelase also specify the summaries of those commits -- for the human readers.

> Due to this reorganisation the polarity used to reset the
> external USB phy changed and USB host doesn't recognize
> any devices.

> Signed-off-by: Juergen Kilb <J.Kilb@phytec.de>

WBR, Sergei
