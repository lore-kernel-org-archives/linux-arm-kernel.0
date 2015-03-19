From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 19 Mar 2015 07:06:14 +0000
Subject: [PATCHv3] mm: Don't offset memmap for flatmem
In-Reply-To: <CAJAp7OhebH088EjXxo0tG__p8m11FiNw8qqG6k8eAky6cg2P8g@mail.gmail.com>
References: <1426291715-16242-1-git-send-email-lauraa@codeaurora.org>
 <CAJAp7OhebH088EjXxo0tG__p8m11FiNw8qqG6k8eAky6cg2P8g@mail.gmail.com>
Message-ID: <550A7566.8070907@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19/03/15 00:21, Bjorn Andersson wrote:
>> the memmap array. Just use the allocated memmap without any offset
>> >when running with CONFIG_FLATMEM to avoid the overrun.
>> >
>> >Signed-off-by: Laura Abbott<lauraa@codeaurora.org>
>> >Reported-by: Srinivas Kandagatla<srinivas.kandagatla@linaro.org>
>> >---
> With this I can boot 8960 and 8064 without patching up the MEM ATAGs
> from the bootloader (as well as "reserving" smem).
>
Yes I forgot the mention this I can boot my IFC6410 without the 
fixup.bin ...\o/ .

--srini
> Tested-by: Bjorn Andersson<bjorn.andersson@sonymobile.com>
>
> Thanks,
