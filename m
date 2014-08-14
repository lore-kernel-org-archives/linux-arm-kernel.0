From: broonie@kernel.org (Mark Brown)
Date: Thu, 14 Aug 2014 17:40:00 +0100
Subject: [PATCH v5 0/7] Add MFD and regulator drivers for Hi6421 PMIC SoC
In-Reply-To: <CAD6h2NQ7jfP6A4TV0Lw4hpKGO2oeJ90tEM0u-J5mYBBQ7M=+Rw@mail.gmail.com>
References: <1407929624-8737-1-git-send-email-guodong.xu@linaro.org>
 <20140813185357.GH17528@sirena.org.uk>
 <CAD6h2NQ7jfP6A4TV0Lw4hpKGO2oeJ90tEM0u-J5mYBBQ7M=+Rw@mail.gmail.com>
Message-ID: <20140814164000.GC17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 14, 2014 at 08:51:09AM +0800, Haojian Zhuang wrote:

> Thanks a lot on taking these patches. Please left the patch of
> hi3xxx_defconfig. We plan to go through armsoc tree by ourselves since
> some following patches will rename it to hisi_defconfig. The reason is
> that we need to support HiP04 SoC in the same defconfig. So three
> Hisilicon SoC will be supported by hi3xxx_defconfig, but only Hi3620
> belongs to hi3xxx.

Like I said I'm only going to take the regulator patches - I also won't
be taking the MFD patch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140814/e4929559/attachment.sig>
