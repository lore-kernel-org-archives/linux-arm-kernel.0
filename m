From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Mar 2018 15:34:42 +0100
Subject: [GIT PULL 1/2] Rockchip dts32 fixes for 4.16
In-Reply-To: <22043255.iBjVuxpHK5@phil>
References: <22043255.iBjVuxpHK5@phil>
Message-ID: <CAK8P3a21GKhqGX04u4p3B9ck-D4RPMqwcdsjJoteEM3p6Aoz0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2018 at 9:37 AM, Heiko Stuebner <heiko@sntech.de> wrote:
> Hi Arnd, Kevin, Olof
>
> please find below some more fixes for 4.16 .
>
> I wasn't sure if dtc warning count as fixes, so feel free to ignore the
> arm32 part, but the arm64 changes are somewhat important as they
> fix usb and suspend regressions, so please pull

Pulled into fixes. This one is a bit of a grey area. It's something
that I'd just leave up to you as the downstream maintainer, and
I picked it up since you sent the pull request.

       Arnd
