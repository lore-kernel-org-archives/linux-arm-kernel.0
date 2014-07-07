From: romieu@fr.zoreil.com (Francois Romieu)
Date: Mon, 7 Jul 2014 23:22:07 +0200
Subject: [PATCH 1/3] ethernet: Add new driver for Marvell Armada 375
 network unit
In-Reply-To: <20140707142653.GA18910@arch.cereza>
References: <1404498697-21978-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1404498697-21978-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140705210359.GA19441@electric-eye.fr.zoreil.com>
 <20140707142653.GA18910@arch.cereza>
Message-ID: <20140707212207.GB16677@electric-eye.fr.zoreil.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ezequiel Garcia <ezequiel.garcia@free-electrons.com> :
[...]
> Hm, yes, I see what you mean. These names bother me too, and I think we could
> probably change it so "pp2" is "dev", and "pp" is "port". But on the other
> side, I'm not sure it's worth doing such an intrusive change just to fix these
> names.
> 
> What do you think ?

Yike. Please don't substitute "pp2" with some "dev": it's a "priv" more than
a "dev". s/pp/port/ would be good enough. Your call.

-- 
Ueimor
