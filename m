From: tony@atomide.com (Tony Lindgren)
Date: Mon, 24 Oct 2016 14:29:33 -0700
Subject: [RFC] shutdown machine when li-ion battery goes below 3V
In-Reply-To: <20161024212250.GA31336@amd>
References: <20161024212250.GA31336@amd>
Message-ID: <20161024212932.uhjz752z2cy5hohl@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [161024 14:24]:
> Hi!
> 
> What about something like this? N900 will drain the battery down to
> system crash, which is quite uncool.

Can't we make that generic and configurable for the voltage somehow?

Also, the shutdown voltage can depend on external devices connected.
It could be for example 3.3V depending on eMMC on some devices while
devices with no eMMC could have it at 3.0V.

Regards,

Tony
