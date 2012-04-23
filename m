From: viresh.linux@gmail.com (viresh kumar)
Date: Mon, 23 Apr 2012 17:17:59 +0530
Subject: [PATCH 1/9] SPEAr13xx: Add header files
In-Reply-To: <201204211837.35023.arnd@arndb.de>
References: <cover.1334942163.git.viresh.kumar@st.com>
 <201204201752.05657.arnd@arndb.de>
 <CAOh2x=ncefojSYBPUVgL1EKcQ+wPFzfCmo+TZ+3BEmwD+=Q=Gg@mail.gmail.com>
 <201204211837.35023.arnd@arndb.de>
Message-ID: <CAOh2x==CVfODg=iOKPrQq2HYMAEFUBpwkrkZwW3f5As7Z2pTdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 22, 2012 at 12:07 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> It's still really ugly to have that in a global header file, including the
> hardcoded register addresses.

I will check if i can move this to clock.c for now, to move things quicker. :)

--
viresh
