From: tony@atomide.com (Tony Lindgren)
Date: Tue, 28 Feb 2017 08:50:54 -0800
Subject: [PATCH] ARM: dts: am335x-pcm953: Fix legacy wakeup source binding
In-Reply-To: <1486729747-4604-1-git-send-email-t.remmet@phytec.de>
References: <1486729747-4604-1-git-send-email-t.remmet@phytec.de>
Message-ID: <20170228165054.GU21809@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Teresa Remmet <t.remmet@phytec.de> [170210 04:31]:
> Replaced the legacy binding "gpio-key,wakeup" with "wakeup-source" as
> noted in the kernel documentation.

Applying this finally into omap-for-v4.11/fixes thanks.

Tony
