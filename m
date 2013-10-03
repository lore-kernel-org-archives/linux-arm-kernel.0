From: olof@lixom.net (Olof Johansson)
Date: Wed, 2 Oct 2013 20:57:57 -0700
Subject: [PATCH, FIX] ARM: mvebu: add missing DT Mbus ranges and relocate
 PCIe DT nodes for RN102
In-Reply-To: <87a9iuq7ff.fsf@natisbad.org>
References: <87a9iuq7ff.fsf@natisbad.org>
Message-ID: <CAOesGMjs=_USrFR9EkzksBj=7=1CgyujqvNhDZhpfdgkTt6gJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 30, 2013 at 3:19 PM, Arnaud Ebalard <arno@natisbad.org> wrote:
>
> When 5e12a613 and 0cd3754a were introduced, Netgear ReadyNAS 102 .dts
> file was queued for inclusion and missed the update to have Mbus (and
> then BootROM) ranges properties declared. It also missed the relocation
> of Armada 370/XP PCIe DT nodes introduced by 14fd8ed0 after de1af8d4.
> This patch fixes that which makes 3.12-rc3 bootable on the NAS.

In the future please don't just quote the SHAs, give the patch subject
as well. It makes it easier to follow the patch description without
looking them up (besides, there's a chance that the 8-character SHAs
will not be unique at some point in the future, which makes the lookup
harder).


-Olof
