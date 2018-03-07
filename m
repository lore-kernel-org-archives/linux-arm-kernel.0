From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Mar 2018 16:02:49 +0100
Subject: [GIT PULL 1/3] DaVinci SoC support updates for v4.17
In-Reply-To: <20180227075745.23970-1-nsekhar@ti.com>
References: <20180227075745.23970-1-nsekhar@ti.com>
Message-ID: <CAK8P3a2OS5+-0Ds33NgJ=Jbc_9+uNwgMbJ-G3PaUmR05McggWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 27, 2018 at 8:57 AM, Sekhar Nori <nsekhar@ti.com> wrote:
> Miscellaneous DaVinci SoC support improvements for v4.17
>
> * rationalization of con_id names for phy clocks to make DT conversion easy
>
> * A patch to move away from syscon as platform device. This is needed for
>   common clock framework conversion as well as helps get rid of
>   syscon_regmap_lookup_by_pdevname() by removing the last known user.
>
> * convert mach-davinci to use reset support available in watchdog driver
>
> * a non-critical warning fix. It has been around since beginning so not sending
>   as a standalone fix for -rc cycle.
>
> * moving mach-davinci clock init to .init_time() for legacy boot. This is
>   again in preparation for CCF conversion.

Pulled into next/soc, thanks!

     Arnd
