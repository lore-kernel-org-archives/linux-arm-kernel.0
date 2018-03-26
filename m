From: wei.liu2@citrix.com (Wei Liu)
Date: Mon, 26 Mar 2018 15:07:27 +0100
Subject: [PATCH 4/4] drivers/net: Use octal not symbolic permissions
In-Reply-To: <8f24a711e6b8ec7b41356c378140fb54d510205c.1521845248.git.joe@perches.com>
References: <cover.1521845235.git.joe@perches.com>
 <8f24a711e6b8ec7b41356c378140fb54d510205c.1521845248.git.joe@perches.com>
Message-ID: <20180326140727.4aripztdc2ar6g45@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 23, 2018 at 03:54:39PM -0700, Joe Perches wrote:
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
> ---
>  drivers/net/xen-netback/xenbus.c       |  4 +-
>  drivers/net/xen-netfront.c             |  6 +--

Reviewed-by: Wei Liu <wei.liu2@citrix.com>
