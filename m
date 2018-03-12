From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Mar 2018 15:30:28 +0100
Subject: [GIT PULL] i.MX fixes for 4.16, round 2
In-Reply-To: <20180309061749.GK3217@dragon>
References: <20180309061749.GK3217@dragon>
Message-ID: <CAK8P3a34NZy=MkNF_6RLynamp-G9E_N1Z=x7vxVwQ9yGoZXebw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 9, 2018 at 7:17 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> i.MX fixes for 4.16, 2nd round:
>  - Fix a copy-paste error in imx7d-sdb device tree, which results in two
>    usb-otg regulators are both named "regulator-usb-otg1-vbus" and
>    override each other.

Pulled into fixes, thanks!

      Arnd
