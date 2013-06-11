From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 11 Jun 2013 18:31:37 +0900
Subject: [PATCH] ARM: zImage/virt: remove hyp-stub.S during distclean
In-Reply-To: <20130611074810.GC10440@verge.net.au>
References: <20130610060325.2335.65815.sendpatchset@w520>
 <20130611074810.GC10440@verge.net.au>
Message-ID: <CANqRtoSx_dN3as5ObwFCeRkAQ3NF1O7CYkfVmUXLxBq4hMj2dQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon, Dave, everyone,

On Tue, Jun 11, 2013 at 4:48 PM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Jun 10, 2013 at 03:03:25PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> Make sure hyp-stub.S gets removed during make distclean,
>> this left over file was introduced in commit:
>>
>> 424e599 ARM: zImage/virt: hyp mode entry support for the zImage loader
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>

Acked-by: Dave Martin <dave.martin@linaro.org>

> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Thanks guys, who can pick this up?

Cheers,

/ magnus
