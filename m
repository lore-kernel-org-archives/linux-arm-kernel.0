From: jonathanh@nvidia.com (Jon Hunter)
Date: Fri, 26 Feb 2016 09:12:15 +0000
Subject: [PATCH V2] ARM64: tegra: Add support for Google Pixel C
In-Reply-To: <CAL1qeaHVuvwTkctEMo6TFggPPgqaQZDnKZGYn1QRUROpJ9Dhrw@mail.gmail.com>
References: <1454949199-27050-1-git-send-email-jonathanh@nvidia.com>
 <CAL1qeaHVuvwTkctEMo6TFggPPgqaQZDnKZGYn1QRUROpJ9Dhrw@mail.gmail.com>
Message-ID: <56D016EF.1000404@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 25/02/16 21:07, Andrew Bresticker wrote:
> Jon,
> 
> On Mon, Feb 8, 2016 at 8:33 AM, Jon Hunter <jonathanh@nvidia.com> wrote:
>> Add initial device-tree support for Google Pixel C (a.k.a. Smaug) based
>> upon Tegra210 SoC with 3 GiB of LPDDR4 RAM.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> 
> Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
> 
> ... and I booted up my Smaug with v4.5-rc5 + this patch, so:
> 
> Tested-by: Andrew Bresticker <abrestic@chromium.org>

Thanks. There is a V3 of this patch [0]. The main difference is that it
enables all 4 CPUs. Care of test/ack this version?

Cheers
Jon

[0] http://marc.info/?l=linux-arm-kernel&m=145502094332480&w=4
