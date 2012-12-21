From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 21 Dec 2012 10:08:58 +0100
Subject: [PATCH 3/3] ARM: AT91: IIO: fix missing Sample and Hold time
In-Reply-To: <20121220124909.GR23971@game.jcrosoft.org>
References: <20121219183236.GP23971@game.jcrosoft.org>
 <1355942232-26251-1-git-send-email-plagnioj@jcrosoft.com>
 <1355942232-26251-3-git-send-email-plagnioj@jcrosoft.com>
 <50D2EEA0.8040807@free-electrons.com>
 <20121220124909.GR23971@game.jcrosoft.org>
Message-ID: <50D4272A.1080702@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 20/12/2012 13:49, Jean-Christophe PLAGNIOL-VILLARD a ?crit :
> On 11:55 Thu 20 Dec     , Maxime Ripard wrote:
>> Since, from all the datasheet I have (G20, G45 and X5), the minimum time
>> is always 500ns, do we really need to add a dt property for that?
> you must this is hardware specific it depend on the line capacity

Ok, I see. The comment about adding the unit in the documentation is
still valid though.

Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
