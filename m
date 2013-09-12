From: olof@lixom.net (Olof Johansson)
Date: Wed, 11 Sep 2013 19:33:56 -0700
Subject: [PATCH 0/4] ARM: sun7i: Enable EMAC support for the A20
In-Reply-To: <1378890609-28563-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1378890609-28563-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAOesGMg1hop3f_UdRGFzfPri9Y7V6afxy_S0DkHCYRhm=REppg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 11, 2013 at 2:10 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi everyone,
>
> This patch serie enables the EMAC IP found on the A20. Since it's basically the
> same one than the one found in the A10 and A10s, it's basically just a matter
> of adding the devices to the device tree.
>
> Thanks,
> Maxime
>
> Maxime Ripard (4):
>   ARM: sun7i: Enable the Ethernet in the A20
>   ARM: sun7i: Add the muxing options for the EMAC
>   ARM: sun7i: cubieboard2: Enable the EMAC

Tested-by: Olof Johansson <olof@lixom.net>


-Olof
