From: gnurou@gmail.com (Alexandre Courbot)
Date: Tue, 26 Nov 2013 10:35:58 +0900
Subject: [PATCH v11 7/7] ARM: tegra: support Trusted Foundations by default
In-Reply-To: <20131126000608.GA21634@quad.lixom.net>
References: <1385274652-16415-1-git-send-email-acourbot@nvidia.com>
 <1385274652-16415-8-git-send-email-acourbot@nvidia.com>
 <20131126000608.GA21634@quad.lixom.net>
Message-ID: <CAAVeFu+mMyPhFtVZ09vgYWWCYkPpF3X547ffRAfXXKOOWUUkqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 9:06 AM, Olof Johansson <olof@lixom.net> wrote:
> On Sun, Nov 24, 2013 at 03:30:52PM +0900, Alexandre Courbot wrote:
>> Support for Trusted Foundations is light and allows the kernel to run on
>> a wider range of devices, so enable it by default.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
>> Reviewed-by: Stephen Warren <swarren@nvidia.com>
>> ---
>>  arch/arm/configs/tegra_defconfig | 1 +
>>  1 file changed, 1 insertion(+)
>
> I think we want this enabled on multi_v7_defconfig too? Send a separate
> patch for that once this is merged though.

Will do.

Thanks,
Alex.
