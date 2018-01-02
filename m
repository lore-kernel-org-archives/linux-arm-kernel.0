From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Tue, 2 Jan 2018 10:40:22 -0800
Subject: [PATCH v2 01/21] nvmem: core: Allow specifying device name
 verbatim
In-Reply-To: <ba0b8125-6094-d042-a391-edcc2f68a114@linaro.org>
References: <20180101232310.30420-1-andrew.smirnov@gmail.com>
 <20180101232310.30420-2-andrew.smirnov@gmail.com>
 <ba0b8125-6094-d042-a391-edcc2f68a114@linaro.org>
Message-ID: <CAHQ1cqEnRL=Lwk_35NVR9r-mQ8giJ=mku+WGxp8gAMm_1Wi__w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 2, 2018 at 3:44 AM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
> Thanks for the Patch,
>
> On 01/01/18 23:22, Andrey Smirnov wrote:
>>
>> Add code to allow avoid having nvmem core append a numeric suffix to
>> the end of the name by passing config->id of -1.
>>
>> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Cc: Heiko Stuebner <heiko@sntech.de>
>> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Cc: Carlo Caione <carlo@caione.org>
>> Cc: Kevin Hilman <khilman@baylibre.com>
>> Cc: Matthias Brugger <matthias.bgg@gmail.com>
>> Cc: cphealy at gmail.com
>> Cc: linux-kernel at vger.kernel.org
>> Cc: linux-mediatek at lists.infradead.org
>> Cc: linux-rockchip at lists.infradead.org
>> Cc: linux-amlogic at lists.infradead.org
>> Cc: linux-arm-kernel at lists.infradead.org
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>   drivers/nvmem/core.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
> This looks fine for me, Can you also add a line in kernel doc about this
> behavior.
>

Sure, will do in v3.

Thanks,
Andrey Smirnov
