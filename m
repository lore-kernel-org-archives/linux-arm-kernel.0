From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 25 Mar 2013 17:44:27 +0800
Subject: [PATCH 5/8] ARM: sirf: move debug-macro.S to include/debug/sirf.S
In-Reply-To: <1363779679-16880-6-git-send-email-arnd@arndb.de>
References: <1363779679-16880-1-git-send-email-arnd@arndb.de>
 <1363779679-16880-6-git-send-email-arnd@arndb.de>
Message-ID: <CAGsJ_4yeuK1L=nOJWqyWNHw5xtXeSUC6FHPhV4W4XJD87HyN_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/20, Arnd Bergmann <arnd@arndb.de>:
> The new style ll_debug implementation for multiplatform requires the
> platform glue to be in include/debug, so let's move it there to
> separate the debugging logic from the platform code.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Tested-by: Barry Song <Baohua.Song@csr.com>
