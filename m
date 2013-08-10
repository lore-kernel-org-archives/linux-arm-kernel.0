From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Sun, 11 Aug 2013 01:33:39 +0300
Subject: [PATCH] arch/arm/mach-pxa/stargate2.c: use ARRAY_AND_SIZE
 consistently
In-Reply-To: <1376148353-9699-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1376148353-9699-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20130810223338.GM5502@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARRAY_AND_SIZE() macro is horrible, and I would like it if it were
removed.  What I meant before was just that probably people will
probably complain if we try to remove it.

regards,
dan carpenter
