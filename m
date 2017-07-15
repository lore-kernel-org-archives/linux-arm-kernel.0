From: joe@perches.com (Joe Perches)
Date: Sat, 15 Jul 2017 13:37:59 -0700
Subject: [PATCH 00/11] Drop unnecessary static
In-Reply-To: <1500149266-32357-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1500149266-32357-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1500151079.4457.80.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2017-07-15 at 22:07 +0200, Julia Lawall wrote:
> These patches fix cases where there is a static on a local variable, but
> the variable is initialized before any possible use.  Thus, the static has
> no benefit.

Nice one.
