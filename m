From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 5 Sep 2012 11:15:28 +0200
Subject: [PATCH 3/8] gpio: 74x164: Remove platform data and use dynamic
 gpio number assignment
In-Reply-To: <9763805.kende5OlsI@flexo>
References: <1346834457-6257-1-git-send-email-maxime.ripard@free-electrons.com>
 <1346834457-6257-3-git-send-email-maxime.ripard@free-electrons.com>
 <9763805.kende5OlsI@flexo>
Message-ID: <20120905111528.7fe8b8e9@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Wed, 05 Sep 2012 10:48:14 +0200,
Florian Fainelli <florian@openwrt.org> a ?crit :

> On Wednesday 05 September 2012 10:40:52 Maxime Ripard wrote:
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> No, please don't do it that way, rather check if the platform_data pointer is 
> null, and if it is, fall-back to dynamic gpio base assignment. There is a 
> currently out of tree user of this for which it matters to be able to set a 
> specific gpio base numbering.

Do we care about out of tree users?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
