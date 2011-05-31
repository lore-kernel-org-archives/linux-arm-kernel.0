From: tony@atomide.com (Tony Lindgren)
Date: Tue, 31 May 2011 02:34:23 -0700
Subject: [PATCHv2 1/2] omap: rx51: Set regulator V28_A always on
In-Reply-To: <1306830421-25727-1-git-send-email-jhnikula@gmail.com>
References: <1306830421-25727-1-git-send-email-jhnikula@gmail.com>
Message-ID: <20110531093423.GP11352@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jarkko Nikula <jhnikula@gmail.com> [110531 01:22]:
> The V28_A domain in Nokia N900 that supplies VDD voltages to TLV320AIC34 and
> TPA6130A2 should not be shutdown. This is because otherwise there will be
> leak from VIO to VDD in TLV320AIC34 and this leak consumes more battery
> current that is saved from keeping V28_A off. With this patch the battery
> current consumption is approximately 1.5 mA lower.

Thanks, applying into fixes.

Tony
