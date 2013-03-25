From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 25 Mar 2013 17:27:06 +0800
Subject: [PATCH 6/8] ARM: sirf: use clocksource_of infrastructure
In-Reply-To: <1363779679-16880-7-git-send-email-arnd@arndb.de>
References: <1363779679-16880-1-git-send-email-arnd@arndb.de>
 <1363779679-16880-7-git-send-email-arnd@arndb.de>
Message-ID: <CAGsJ_4zs-j83dq-hJKLRt68e1SFETsiy2b+0JU8Lksdu71FUTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/20, Arnd Bergmann <arnd@arndb.de>:
> This moves the two sirf clocksource drivers to drivers/clocksource
> and integrates them into the framework for locating the clock sources
> automatically.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>

Tested-by: Barry Song <Baohua.Song@csr.com>

-barry
