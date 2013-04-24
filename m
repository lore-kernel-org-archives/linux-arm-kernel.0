From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 24 Apr 2013 08:50:27 +0530
Subject: [PATCH 13/21] misc: mark spear13xx-pcie-gadget as broken
In-Reply-To: <1366734653-488286-14-git-send-email-arnd@arndb.de>
References: <1366734653-488286-1-git-send-email-arnd@arndb.de>
 <1366734653-488286-14-git-send-email-arnd@arndb.de>
Message-ID: <CAOh2x=nEqqnPjmSVOMTx1oKvCPmZaGDUAb6sOOmMhJb-XemBCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 10:00 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> This driver was merged in 2.6.38 but never actually compiled because
> it depends on the <mach/pcie.h> header that has not made it into the
> kernel. Starting with Linux-3.10, this results in "allyesconfig"
> build errors, since spear13xx can now be enabled with the default
> "multiplatform" platform on ARM. Let's mark it as broken for now.
> If it doesn't get fixed, we can drop it completely.
>
> Cc: Pratyush Anand <pratyush.anand@st.com>
> Cc: Randy Dunlap <randy.dunlap@oracle.com>
> Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
> Cc: Viresh Kumar <viresh.kumar@st.com>
> Cc: Shiraz Hashim <shiraz.hashim@st.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/misc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

@Pratyush: Please see if we can get it fixed soon.
