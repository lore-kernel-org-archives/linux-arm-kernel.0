From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Tue, 2 Jan 2018 10:40:57 -0800
Subject: [PATCH v2 02/21] nvmem: Introduce devm_nvmem_(un)register()
In-Reply-To: <f3ffb0f7-2d27-9c58-549f-dc44209f27c6@linaro.org>
References: <20180101232310.30420-1-andrew.smirnov@gmail.com>
 <20180101232310.30420-3-andrew.smirnov@gmail.com>
 <f3ffb0f7-2d27-9c58-549f-dc44209f27c6@linaro.org>
Message-ID: <CAHQ1cqGTophCKYsf=c_YECwBt8tQRhpT0wfvQwVxj+YyJO49xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 2, 2018 at 3:44 AM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
> Thanks for the patch,
>
> On 01/01/18 23:22, Andrey Smirnov wrote:
>>
>> Introduce devm_nvmem_register()/devm_nvmem_unregister() to make
>> .remove() unnecessary in trivial drivers.
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
>>   drivers/nvmem/core.c           | 41
>> +++++++++++++++++++++++++++++++++++++++++
>>   include/linux/nvmem-provider.h | 17 +++++++++++++++++
>>   2 files changed, 58 insertions(+)
>>
> Patch looks good, kernel doc for these exported symbols are missing, you
> should add them in next version!
>

Good point! Will do in v3.

Thanks,
Andrey Smirnov
