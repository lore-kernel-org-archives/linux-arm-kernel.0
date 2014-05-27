From: tony@atomide.com (Tony Lindgren)
Date: Tue, 27 May 2014 13:40:25 -0700
Subject: [PATCH 5/5] ARM: dts: OMAP3 a83x: fix duplicate usb pin config
In-Reply-To: <1400799986-20043-6-git-send-email-chf.fritz@googlemail.com>
References: <1400799986-20043-1-git-send-email-chf.fritz@googlemail.com>
 <1400799986-20043-6-git-send-email-chf.fritz@googlemail.com>
Message-ID: <20140527204025.GD32336@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Christoph Fritz <chf.fritz@googlemail.com> [140522 16:07]:
> Node usbhshost is supporting pinctrl, so the deprecated
> quirk call can be removed.

Applying this too into omap-for-v3.16/dt-v2 thanks.

Tony
