From: olof@lixom.net (Olof Johansson)
Date: Mon, 24 Sep 2012 08:21:00 -0700
Subject: [PATCH v3 1/2] ARM: Remove bcmring NAND driver
In-Reply-To: <1348499187.4880.66.camel@sauron.fi.intel.com>
References: <1348263626-3087-1-git-send-email-csd@broadcom.com>
 <1348263626-3087-2-git-send-email-csd@broadcom.com>
 <1348499187.4880.66.camel@sauron.fi.intel.com>
Message-ID: <CAOesGMgs6Vq4yhKP6_4qHkJjo5vij=ww9VN7Yfz7QYxT95Ntaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2012 at 8:06 AM, Artem Bityutskiy <dedekind1@gmail.com> wrote:
> On Fri, 2012-09-21 at 14:40 -0700, Christian Daudt wrote:
>> This driver is being removed as part of the cleanup of the bcmring
>> SoC from mainline as it is no longer maintained.
>>
>> Signed-off-by: Christian Daudt <csd@broadcom.com>
>> Reviewed-by: Jiandong Zheng <jdzheng@broadcom.com>
>> Acked-by: Will Deacon <will.deacon@arm.com>
>
> Pushed this patch to l2-mtd.git. But if you decide to merge it via
> Arnd's tree (probably better idea) - let me know, I'll drop it.

Keeping it in mtd is fine.


-Olof
