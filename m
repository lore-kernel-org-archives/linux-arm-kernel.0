From: olof@lixom.net (Olof Johansson)
Date: Thu, 12 Sep 2013 12:25:26 -0700
Subject: [PATCH 0/4] ARM: sun7i: Enable EMAC support for the A20
In-Reply-To: <1378890609-28563-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1378890609-28563-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAOesGMgfk=sEgTA1hFhg175BfMS+Ku8RYyZ0NQpGbA2d0BZ9LA@mail.gmail.com>
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
>   ARM: sun7i: olinuxino-micro: Enable the EMAC

Maxime,

Since this improves test coverage for me (I have a cubie2 that I can
now nfsroot-boot for testing), I'll apply these in the last batch of
changes (fixes) for 3.12.

It's all trivially small additions to newly added dts files, so
there's nothing to regress w.r.t. previous releases and risk is
overall low.


Thanks!

-Olof
