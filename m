From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Apr 2016 12:56:55 +0200
Subject: [PATCH] arch/defconfig: remove CONFIG_RESOURCE_COUNTERS
In-Reply-To: <146105442758.18940.2792564159961963110.stgit@zurg>
References: <146105442758.18940.2792564159961963110.stgit@zurg>
Message-ID: <4214150.v1WFzl5UmK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 April 2016 11:27:07 Konstantin Khlebnikov wrote:
> This option replaced by PAGE_COUNTER which is selected by MEMCG.
> 
> Signed-off-by: Konstantin Khlebnikov <koct9i@gmail.com>
> 
Acked-by: Arnd Bergmann <arnd@arndb.de>
