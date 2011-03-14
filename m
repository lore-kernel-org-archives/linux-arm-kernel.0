From: tony@atomide.com (Tony Lindgren)
Date: Mon, 14 Mar 2011 11:12:59 -0700
Subject: [PATCH] omap: zoom: host should not pull up wl1271's irq line
In-Reply-To: <1300112665-6253-1-git-send-email-ohad@wizery.com>
References: <1300112665-6253-1-git-send-email-ohad@wizery.com>
Message-ID: <20110314181259.GF7258@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ohad Ben-Cohen <ohad@wizery.com> [110314 07:29]:
> The wl1271's irq line is completely controlled by the 1271 device, and
> the host does not not need to pull it up.
> 
> While there's no functional effect, letting the host pull this line up is
> just redundant, and wastes power.

Applying.

Tony
