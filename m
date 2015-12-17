From: tony@atomide.com (Tony Lindgren)
Date: Thu, 17 Dec 2015 09:58:13 -0800
Subject: [PATCH 09/19] ARM: dts: am335x: replace gpio-key,wakeup with
 wakeup-source property
In-Reply-To: <567040E7.7060308@arm.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
 <1445422216-29375-10-git-send-email-sudeep.holla@arm.com>
 <567040E7.7060308@arm.com>
Message-ID: <20151217175812.GU23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sudeep Holla <sudeep.holla@arm.com> [151215 08:33]:
> 
> 
> On 21/10/15 11:10, Sudeep Holla wrote:
> >Though the keyboard driver for GPIO buttons(gpio-keys) will continue to
> >check for/support the legacy "gpio-key,wakeup" boolean property to
> >enable gpio buttons as wakeup source, "wakeup-source" is the new
> >standard binding.
> >
> >This patch replaces the legacy "gpio-key,wakeup" with the unified
> >"wakeup-source" property in order to avoid any futher copy-paste
> >duplication.
> >
> >Cc: "Beno?t Cousson" <bcousson@baylibre.com>
> >Cc: Tony Lindgren <tony@atomide.com>
> 
> Ping, do you prefer taking via your tree or should I send to armsoc
> directly ?

Sorry I did not realized you're waiting for me to pick this one,
applying into omap-for-v4.5/dt thanks.

Tony
