From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 27 Mar 2017 08:29:25 +0100
Subject: [PATCH v2] arm: Fix memory attribute inconsistencies when using
 fixmap
In-Reply-To: <20170324201736.GA3317@afzalpc>
References: <20170321173030.7751-1-tixy@linaro.org>
 <1490117781.3136.9.camel@linaro.org>
 <CAKv+Gu82PsyyC=fQHxUn5mrCdmQvhwK+DK342-vv8y53mLcpng@mail.gmail.com>
 <1490175988.2890.1.camel@linaro.org>
 <CAKv+Gu8VoSLOUiNSXsrtQUr8TQdGBqiOmhsKS+N2dhToMusOUg@mail.gmail.com>
 <1490196388.2890.8.camel@linaro.org> <20170324201736.GA3317@afzalpc>
Message-ID: <CAKv+Gu8sU9burJh6sX6hREuqPwLatf-FVZ=5SbGsB0Sorf8Z8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 March 2017 at 20:17, afzal mohammed <afzal.mohd.ma@gmail.com> wrote:
> Hi,
>
> On Wed, Mar 22, 2017 at 03:26:28PM +0000, Jon Medhurst (Tixy) wrote:
>> > > On Tue, 2017-03-21 at 19:00 +0000, Ard Biesheuvel wrote:
>
>> > > > It looks like nommu should be unaffected, but it is worth giving it a
>> > > > spin as well
>>
>> After much faffing around I got MPS2 booting a Linux kernel, and
>> somewhat to my surprise it seems to boot fine, all the way up to
>> panicking because it didn't find an init. This was with $subject patch.
>
> Vybrid VF610 Cortex M4 boots to prompt w/ this patch on current mainline.
>
> Vybrid VF610 Cortex A5 using !MMU Kernel w/ this patch too boots to
> prompt (climbing onto the shoulder's of Vladimir, not Torvalds HEAD)
>

Thanks for testing!

I suppose this patch is ready to go into the patch system, with
Afzal's tested-by as well as mine.
