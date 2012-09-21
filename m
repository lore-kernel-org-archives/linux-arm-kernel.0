From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 21 Sep 2012 13:39:59 -0300
Subject: [PATCH 01/11] ARM: defconfig: Remove CONFIG_MISC_DEVICES
In-Reply-To: <201209211449.56906.arnd@arndb.de>
References: <1345307035-3545-1-git-send-email-festevam@gmail.com>
 <CAOMZO5C2ihKUeQk17JOHc9VXAB3KTeQLS3OcLOiiUC8jucsexg@mail.gmail.com>
 <CAOMZO5C2rTBM6si0MUC7XWznwqwmUq5-LmFyekLab8UBVwaCFw@mail.gmail.com>
 <201209211449.56906.arnd@arndb.de>
Message-ID: <CAOMZO5DwwxFz30hHVyUWPBwEzCD+qcoxE6ef3t758MHd72JdKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, Sep 21, 2012 at 11:49 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> Sorry for not replying earlier. We could merge these through the
> arm-soc tree, but I'm not actually sure if they are necessary.
>
> For all I know, listing a nonexisting configuration option in
> a defconfig file has no effect, and the files get recreated
> whenever the maintainers choose to.

My intention with this series is merely to provide a cleanup in the
defconfigs, so that they do not include an non-existing configuration.
I know it is not harmful to let the CONFIG_MISC_DEVICES there, but
after my commit 7c5763 I think we should get rid of
CONFIG_MISC_DEVICES completely.

I saw that the ia64 Intel patch from this series was already applied
into mainline and I also got some other Acks from different
architectures.

Regards,

Fabio Estevam
