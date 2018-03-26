From: davem@davemloft.net (David Miller)
Date: Mon, 26 Mar 2018 12:08:20 -0400 (EDT)
Subject: [PATCH 4/4] drivers/net: Use octal not symbolic permissions
In-Reply-To: <8f24a711e6b8ec7b41356c378140fb54d510205c.1521845248.git.joe@perches.com>
References: <cover.1521845235.git.joe@perches.com>
 <8f24a711e6b8ec7b41356c378140fb54d510205c.1521845248.git.joe@perches.com>
Message-ID: <20180326.120820.1903008086350362171.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joe Perches <joe@perches.com>
Date: Fri, 23 Mar 2018 15:54:39 -0700

> Prefer the direct use of octal for permissions.
> 
> Done with checkpatch -f --types=SYMBOLIC_PERMS --fix-inplace
> and some typing.
> 
> Miscellanea:
> 
> o Whitespace neatening around these conversions.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Applied.
