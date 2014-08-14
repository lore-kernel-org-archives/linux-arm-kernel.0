From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu, 14 Aug 2014 08:51:09 +0800
Subject: [PATCH v5 0/7] Add MFD and regulator drivers for Hi6421 PMIC SoC
In-Reply-To: <20140813185357.GH17528@sirena.org.uk>
References: <1407929624-8737-1-git-send-email-guodong.xu@linaro.org>
 <20140813185357.GH17528@sirena.org.uk>
Message-ID: <CAD6h2NQ7jfP6A4TV0Lw4hpKGO2oeJ90tEM0u-J5mYBBQ7M=+Rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 August 2014 02:53, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Aug 13, 2014 at 07:33:37PM +0800, Guodong Xu wrote:
>> This patchset adds an MFD core driver and a regulator driver for Hi6421 PMIC
>> SoC.
>
> The regulator patches here all look good but I'll apply them on multiple
> topic branches so I'll wait until after -rc1 is out so I don't need to
> rebase.

Hi Mark,

Thanks a lot on taking these patches. Please left the patch of
hi3xxx_defconfig. We plan to go through armsoc tree by ourselves since
some following patches will rename it to hisi_defconfig. The reason is
that we need to support HiP04 SoC in the same defconfig. So three
Hisilicon SoC will be supported by hi3xxx_defconfig, but only Hi3620
belongs to hi3xxx.

Best Regards
Haojian
