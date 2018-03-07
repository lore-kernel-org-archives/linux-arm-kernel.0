From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Mar 2018 16:27:14 +0100
Subject: [GIT PULL 4/6] ti-sysc changes for v4.17
In-Reply-To: <pull-1520273005-304551@atomide.com-4>
References: <pull-1520273005-304551@atomide.com>
 <pull-1520273005-304551@atomide.com-4>
Message-ID: <CAK8P3a225rS_2Y6=6As8rYkbE_6P-XTvDkFZw4tsVpuxCOXPPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 5, 2018 at 7:11 PM, Tony Lindgren <tony@atomide.com> wrote:

> ----------------------------------------------------------------
> Driver changes for ti-sysc for v4.17
>
> This series of changes enables the use device tree based sysconfig
> data for ti-sysc driver. As we already have SmartReflex data configured,
> we use that as the first driver to enable. To do that in a way where
> SmartReflex is not probed twice, we need to prepare the SmartReflex
> driver before flipping dts data on for it in the last patch of the
> series.
>
> To avoid regressions, we are checking the passed dts data against
> existing platform data since we still have it available. Then after the
> dts files are converted, we can simply drop the related platform data
> at some point in the future.

Pulled into next/soc, thanks!

        Arnd
