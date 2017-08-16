From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Aug 2017 23:54:20 +0200
Subject: [GIT PULL 3/4] Rockchip dts32 changes for 4.14
In-Reply-To: <10590238.TcdC6IbXJ9@phil>
References: <12145142.47nS8LyXIe@phil> <3167861.YfTzp5M1RE@phil>
 <CAK8P3a1o4N47JO_Y_iW0jb0Q1O=fd_J0Z5pFKktz=U6EXrDw_w@mail.gmail.com>
 <10590238.TcdC6IbXJ9@phil>
Message-ID: <CAK8P3a29Hz5Foxn5W_7vkmeLGLjDkDO-LAOTzMNwG5A1kPyu-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 16, 2017 at 11:42 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> Am Mittwoch, 16. August 2017, 23:10:32 CEST schrieb Arnd Bergmann:
> For the "legacy" socs (if that planned psci enablement does actually
> happen), I'd guess a supporting bootloader would just re-set the
> enable-method in the cpu nodes to psci and enable a yet-to-add
> psci node.
>
> So my personal migration strategy would be to leave it like it is
> on the kernel dt-side and let updated firmware wiggle the
> devicetree into form :-) .
>
> That way backwards-compatibility always stays in place and we
> don't require lock-step upgrades of bootloaders ... especially as
> the plethora of old Rockchip boards out there, sometimes even
> uses completely proprietary loaders.

Yes, sounds good. Thanks!

      Arnd
