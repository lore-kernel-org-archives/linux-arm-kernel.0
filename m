From: tony@atomide.com (Tony Lindgren)
Date: Thu, 17 Dec 2015 09:58:36 -0800
Subject: [PATCH 15/19] ARM: dts: omap: replace legacy *,wakeup property
 with wakeup-source
In-Reply-To: <567041AD.1020702@arm.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
 <1445422216-29375-16-git-send-email-sudeep.holla@arm.com>
 <567041AD.1020702@arm.com>
Message-ID: <20151217175835.GV23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sudeep Holla <sudeep.holla@arm.com> [151215 08:37]:
> 
> 
> On 21/10/15 11:10, Sudeep Holla wrote:
> >Though the keyboard and other driver will continue to support the legacy
> >"gpio-key,wakeup", "linux,wakeup" boolean property to enable the wakeup
> >source, "wakeup-source" is the new standard binding.
> >
> >This patch replaces all the legacy wakeup properties with the unified
> >"wakeup-source" property in order to avoid any futher copy-paste
> >duplication.
> >
> >Cc: "Beno?t Cousson" <bcousson@baylibre.com>
> >Cc: Tony Lindgren <tony@atomide.com>
> 
> Ping, do you prefer taking via your tree or should I send to armsoc
> directly ?

Applying this one too thanks.

Tony
