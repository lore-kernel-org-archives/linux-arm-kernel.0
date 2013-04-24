From: tony@atomide.com (Tony Lindgren)
Date: Wed, 24 Apr 2013 12:44:50 -0700
Subject: Multiple issues with omap4 panda es in linux next
In-Reply-To: <20130419171318.GK10155@atomide.com>
References: <20130419171318.GK10155@atomide.com>
Message-ID: <20130424194450.GD5184@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [130419 10:18]:
> 
> 4. WLAN with wl12xx fails with both legacy and DT booting
> 
> No real output here with the legacy mode, just the usual
> using pinctrl dummy state warning.

The WLAN legacy booting issue was caused by me not having
lib80211 module loaded.

Regards,

Tony
