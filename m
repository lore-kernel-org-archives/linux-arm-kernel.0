From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Nov 2018 22:39:06 +0100
Subject: [PATCH v4 0/20] MMP platform fixes
In-Reply-To: <20181128175324.163202-1-lkundrak@v3.sk>
References: <20181128175324.163202-1-lkundrak@v3.sk>
Message-ID: <CAK8P3a0jN1PBy1oKHrx5abX4OKHVxjgevbUcXbUDPbU+VdvUPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 6:53 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> Hi,
>
> this series contains contains a bunch of MMP2 platform fixes.
>
> Previous spins of the patch set were sent out over the course of last
> three months to the MMP platform maintainers, with Arnd and
> linux-arm-kernel at lists.infradead.org on copy.
>
> Unfortunatelly, MMP maintainers (Eric Miao and Haojian Zhuang) don't
> seem to respond anymore. That's a shame, because the MMP2 support seems to
> in need for some love. The DT/multiplatform kernels can't even boot without
> 14/20, 15/20 and perhaps more.
>
> I'm wondering if this cat gen in via the arm-soc tree? Would it be
> appropriate if I followed up with a MAINTAINERS update in that case?

Yes, sounds good to me. I looked through the series again, and
found one patch that seems wrong to me. Everything else should
just go in.

Patches that are purely bugfixes should probably also get backported
to stable kernels, so please add a 'Cc: stable at vger.kernel.org' tag
in the changelog for things that are required to make older kernels
work correctly (as opposed to adding features that were never supposed
to work), and describe in the changelog which kernel versions should
see that backport.

> The patch set has been tested on an OLPC XO-1.75 laptop.

Excellent!

        Arnd
