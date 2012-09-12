From: viresh.kumar@linaro.org (viresh kumar)
Date: Wed, 12 Sep 2012 08:47:22 +0530
Subject: [PATCH 16/16] ARM: spear: move platform_data definitions
In-Reply-To: <1347368559-31329-4-git-send-email-arnd@arndb.de>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368559-31329-1-git-send-email-arnd@arndb.de>
 <1347368559-31329-4-git-send-email-arnd@arndb.de>
Message-ID: <CAOh2x=me+wSxsODv5SzyfKGJjk4C4bspg5O7WQarnEsZwqEsgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2012 at 6:32 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> Platform data for device drivers should be defined in
> include/linux/platform_data/*.h, not in the architecture
> and platform specific directories.
>
> This moves such data out of the spear include directories
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: Shiraz Hashim <shiraz.hashim@st.com>
> Cc: spear-devel at list.st.com
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
