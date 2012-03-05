From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Mar 2012 11:42:15 -0800
Subject: [PATCH] ARM: omap: pandora: fix usbhs platform data
In-Reply-To: <1329604985-24740-1-git-send-email-notasas@gmail.com>
References: <1329604985-24740-1-git-send-email-notasas@gmail.com>
Message-ID: <20120305194215.GN12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grazvydas Ignotas <notasas@gmail.com> [120218 14:11]:
> It turned out wrong OMAP HSUSB port was configured on pandora,
> but still managed to work somehow. This was noticed after enabling
> in-kernel mux, where USB muxing was causing other devices not to work,
> because hsusb1 pins (instead of hsusb2) were wrongly remuxed, which
> are used for other things on pandora.

Thanks, adding this to fixes-non-critical-part2.

Regards,

Tony
