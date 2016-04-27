From: ddaney@caviumnetworks.com (David Daney)
Date: Wed, 27 Apr 2016 08:40:08 -0700
Subject: [PATCH v5 12/14] arm64, acpi, numa: NUMA support based on SRAT
 and SLIT
In-Reply-To: <CADKHWadTL5dB__Y-LGtoPs_mQQ+A36nnhwJo3muTC_z9X1FZag@mail.gmail.com>
References: <1461116439-22991-1-git-send-email-ddaney.cavm@gmail.com>
 <1461116439-22991-13-git-send-email-ddaney.cavm@gmail.com>
 <CADKHWadFBh2TbyoZSmYJHX24roMQQXf8Kx8rEoLABJ8xaTGL=Q@mail.gmail.com>
 <5720127E.1030307@caviumnetworks.com> <57203A47.9000108@linaro.org>
 <CADKHWadTL5dB__Y-LGtoPs_mQQ+A36nnhwJo3muTC_z9X1FZag@mail.gmail.com>
Message-ID: <5720DD58.3020506@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2016 04:37 AM, Dennis Chen wrote:
> Hi Hanjun,
>
> Thanks for the clarification and some little comments ;-)
>
> On 27 April 2016 at 12:04, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>> Hi Dennis, David,
>>
[...]
>>
>>
>> Yes, we can get such information in /sys/devices/system/node, I think
>> we can only print:
>>
>> ACPI: NUMA: SRAT: PXM x -> MPIDR y -> Node z
> Agree.

I am also in agreement.  I will send a revised patch that implements this.

Thanks,
David.
