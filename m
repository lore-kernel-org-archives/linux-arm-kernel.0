From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 14 Nov 2016 12:52:01 +0100
Subject: [PATCH 0/8] DMA: s3c64xx: Conversion to the new channel request
 API
In-Reply-To: <20161110184210.GA11835@kozik-lap>
References: <1478791076-19528-1-git-send-email-s.nawrocki@samsung.com>
 <CGME20161110184227epcas3p4831c8f0d0fb85cb0fd223a4887ed9398@epcas3p4.samsung.com>
 <20161110184210.GA11835@kozik-lap>
Message-ID: <b70c6454-9e42-26bf-4d09-98b087642014@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/2016 07:42 PM, Krzysztof Kozlowski wrote:
> On Thu, Nov 10, 2016 at 04:17:48PM +0100, Sylwester Nawrocki wrote:
>> > This patch series aims to convert the s3c64xx platform to use
>> > the new DMA channel request API, i.e. this is only meaningful 
>> > for non-dt systems using s3c64xx SoCs.
>> > 
>> > Presumably the first 2 or 4 patches in this series could be queued 
>> > for v4.10-rc1 and the remaining patches could be left for subsequent
>> > release, to avoid non-trivial conflict with patches already applied 
>> > in the ASoC tree.
>
> Sounds good to me. Should I put the ARM/s3c64xx commits on separate
> branch in case someone would like to pull a tag with it?

I think it makes sense to put first 4 patches from the series onto
a separate branch, and the remaining ones would need to wait for
next development cycle.

But of course firstly we need some feedback and Ack on the first
(DMA controller driver) patch.

-- 
Thanks,
Sylwester
