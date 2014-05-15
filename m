From: anders.berg@avagotech.com (Anders Berg)
Date: Thu, 15 May 2014 14:59:00 +0200
Subject: [PATCH v3 0/6] Add platform support for LSI AXM55xx
In-Reply-To: <30207873.oHzEC0kjdd@wuerfel>
References: <cover.1400072260.git.anders.berg@avagotech.com>
 <6334605.NlytHCzYVP@wuerfel>
 <CAE0=X_15Yk3VhHTwG-piA_eYL1mKW9wu_Szp-yL0YyfL8m0ecA@mail.gmail.com>
 <30207873.oHzEC0kjdd@wuerfel>
Message-ID: <CAE0=X_2YsfGRZHC5XY0F-5Td_k20s7ADRhhv=3a9bRT7wqxNGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 2:39 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> I don't see the dependency: The clock driver is built only when CONFIG_ARCH_AXXIA
> is set, and that only gets introduced in the platform patches. As long
> as the header files come with the platform, it should be fine.

You're right of course. I didn't think that all the way though...

I'll send a v4 of the series (minus the clk patch) when I get an OK on
the binding of the clk driver.

/Anders
