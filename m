From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Oct 2017 10:15:09 +0100
Subject: [GIT PULL] updates to soc/fsl drivers for v4.14
In-Reply-To: <AM4PR0401MB16998510F0829600808638A08F5A0@AM4PR0401MB1699.eurprd04.prod.outlook.com>
References: <1506109046-11527-1-git-send-email-leoyang.li@nxp.com>
 <CAK8P3a3cyiOgFXAyADH==L=0P621ucp3Xy0F3kBezV5EW9WdDQ@mail.gmail.com>
 <AM4PR0401MB1699CA477F157A2C7618492D8F430@AM4PR0401MB1699.eurprd04.prod.outlook.com>
 <20171023011115.GF8700@dragon>
 <CAK8P3a3ePm25vEnTTLpKAwj_GZf3Hc-VivTJZCvhsH0ivwTMaQ@mail.gmail.com>
 <AM4PR0401MB16998510F0829600808638A08F5A0@AM4PR0401MB1699.eurprd04.prod.outlook.com>
Message-ID: <CAK8P3a2RoLsOgtb=RG-T-iMt8F=9fVq4DibLZAD97us6=VUvgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 27, 2017 at 7:33 PM, Leo Li <leoyang.li@nxp.com> wrote:

>> I'm obviously aware of your product lines and the differences, it was just a bit
>> surprising to get the pull request from you after we had earlier agreed that
>> Shawn would help you handle the pull requests for all NXP products, as he did
>> with the changes to arch/arm/ (LS1021A) and arch/arm64 for various
>> Layerscape products we support (LS1012a, LS1043a, LS1088a, and LS2XXXa so
>> far).
>
> My understanding of the previous agreement was that it only covers device tree
> patches which doesn't need too much detail knowledge of the device itself as long
> as it follows the existing bindings; while the drivers for on-chip devices are still
> handled by us (previously Scott Wood) as it requires a lot more knowledge about
> the device internal.

We probably just didn't make it clear enough and were making different
assumptions.
With the other platforms in arm-soc, I always get all changes
concerning one platform
from a single person, who will then make sure things get merged in the correct
order.

OTOH, having two separate downstream maintainers does have an advantage that it
makes it harder to run into incompatible DT binding changes, as each
tree will get
more testing by itself.

        Arnd
