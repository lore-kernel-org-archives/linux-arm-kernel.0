From: tony@atomide.com (Tony Lindgren)
Date: Mon, 22 Feb 2016 09:57:26 -0800
Subject: [PATCH] ARM: dts: omap3-n900: Allow gpio keys to be disabled
In-Reply-To: <1456152179-12558-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <20160212215326.GD19432@atomide.com>
 <1456152179-12558-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Message-ID: <20160222175726.GJ13417@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [160222 06:43]:
> Add linux,can-disable; to all gpios exported from gpio-keys driver, so
> userspace can disable them

Thanks applying into omap-for-v4.6/dt.

Tony
