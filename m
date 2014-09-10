From: davem@davemloft.net (David Miller)
Date: Tue, 09 Sep 2014 20:40:20 -0700 (PDT)
Subject: [PATCH 1/3] kbuild: remove unnecessary "obj- := dummy.o" trick
In-Reply-To: <1410258381-7088-2-git-send-email-yamada.m@jp.panasonic.com>
References: <1410258381-7088-1-git-send-email-yamada.m@jp.panasonic.com>
 <1410258381-7088-2-git-send-email-yamada.m@jp.panasonic.com>
Message-ID: <20140909.204020.352836914323089696.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Masahiro Yamada <yamada.m@jp.panasonic.com>
Date: Tue,  9 Sep 2014 19:26:19 +0900

> In these Makefiles, at least one of "obj-y" and "obj-" is non-empty,
> hence built-in.o is always created without such a trick.
> 
> Signed-off-by: Masahiro Yamada <yamada.m@jp.panasonic.com>

For networking:

Acked-by: David S. Miller <davem@davemloft.net>
