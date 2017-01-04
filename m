From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Jan 2017 16:44:28 +0100
Subject: [GIT PULL] DaVinci fixes for v4.10
In-Reply-To: <20170104121354.8467-1-nsekhar@ti.com>
References: <20170104121354.8467-1-nsekhar@ti.com>
Message-ID: <2124849.yfmiIrzMNA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, January 4, 2017 5:43:54 PM CET Sekhar Nori wrote:
> This pull request contains fixes for the following issues
> 
> 1) Fix two instances of infinite loop occurring in
>    clock list for DA850. This fixes kernel hangs in some
>    instances and so have been marked for stable kernel.
> 
> 2) Fix for sleeping function called from atomic context
>    with USB 2.0 clock management code introduced in v4.10
>    merge window.
> 
> 

Pulled into fixes, thanks!

	Arnd
