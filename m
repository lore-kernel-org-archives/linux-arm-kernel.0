From: tony@atomide.com (Tony Lindgren)
Date: Sun, 28 Jun 2015 23:47:17 -0700
Subject: [PATCH 2/3] ARM: dts: configure regulators for Gumstix Pepper
In-Reply-To: <1433441299-18887-3-git-send-email-arun@gumstix.com>
References: <1433441299-18887-1-git-send-email-arun@gumstix.com>
 <1433441299-18887-3-git-send-email-arun@gumstix.com>
Message-ID: <20150629064717.GR4156@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arun Bharadwaj <arun@gumstix.com> [150604 11:10]:
> From: Adam YH Lee <adam.yh.lee@gmail.com>
> 
> Boot process is halting in midway because some of the necessary voltage
> regulators are deemed unused and subsequently powered off, leading to
> a completely unresponsive system.

OK that needs to be fixed for v4.2-rc series.
 
> Most of the device nodes had correct voltage regulator attachments.
> Yet these nodes had to set stricter enforcement on them through
> 'regulator-boot-on' and 'regulator-always-on' to function correctly.

That's a lot of regulators marked as regulator-always-on. Could
you please update the description what consumers are using them
so we know why they are all needed always-on?
 
> Signed-off-by: Ash Charles <ashcharles@gmail.com>

>From Adam, sent by Arun, signed by Ash? Can you please check
that too.

Regards,

Tony
