From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Fri, 12 Apr 2013 05:55:39 -0700
Subject: [PATCH v2] net: mv643xx_eth: remove deprecated inet_lro support
In-Reply-To: <1365758400-12565-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1365707488-28819-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1365758400-12565-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1365771339.4459.0.camel@edumazet-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-04-12 at 11:20 +0200, Sebastian Hesselbarth wrote:
> With recent support for GRO, there is no need to keep both LRO and
> GRO. This patch therefore removes the deprecated inet_lro support
> from mv643xx_eth. This is work is based on an experimental patch
> provided by Eric Dumazet and Willy Tarreau.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Based-on-patch-by: Eric Dumazet <eric.dumazet@gmail.com>
> Based-on-patch-by: Willy Tarreau <w@1wt.eu>
> ---
> Changes from v1:
> - also remove INET_LRO from Kconfig (Reported by Eric Dumazet)

Thanks for finishing this patch

Signed-off-by: Eric Dumazet <edumazet@google.com>
