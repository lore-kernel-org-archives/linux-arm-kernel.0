From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 5 Sep 2012 11:17:32 +0200
Subject: [PATCH 3/8] gpio: 74x164: Remove platform data and use dynamic
 gpio number assignment
In-Reply-To: <1346834457-6257-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1346834457-6257-1-git-send-email-maxime.ripard@free-electrons.com>
 <1346834457-6257-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20120905111732.0f7d4add@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Wed,  5 Sep 2012 10:40:52 +0200,
Maxime Ripard <maxime.ripard@free-electrons.com> a ?crit :

> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

You should probably explicitly mention that the platform_data thing is
removed because it has no users in-tree.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
