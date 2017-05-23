From: guodong.xu@linaro.org (Guodong Xu)
Date: Tue, 23 May 2017 19:39:16 +0800
Subject: [PATCH 10/12] arm64: dts: hi3660: add spi device nodes
In-Reply-To: <20170523004627.caeoqezj3leydj2t@rob-hp-laptop>
References: <20170517083745.24479-1-guodong.xu@linaro.org>
 <20170517083745.24479-11-guodong.xu@linaro.org>
 <20170523004627.caeoqezj3leydj2t@rob-hp-laptop>
Message-ID: <CAFGCpxyy0vmGhEHEJ3inn98RsO3Fshkw=_RWr_9XQCXiS-C-1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 23, 2017 at 8:46 AM, Rob Herring <robh@kernel.org> wrote:
> On Wed, May 17, 2017 at 04:37:43PM +0800, Guodong Xu wrote:
>> From: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>
>>
>> Add spi2 and spi3 device nodes for hi3660, and enable them for hikey960.
>>
>> On HiKey960:
>>  - SPI2 is wired out through low speed expansion connector.
>>  - SPI3 is wired out through high speed expansion connector.
>>
>> Signed-off-by: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>
>> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
>> ---
>>  arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts |  8 ++++++
>>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi         | 30 +++++++++++++++++++++++
>>  2 files changed, 38 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
>> index 69aa207..79735ee 100644
>> --- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
>> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
>> @@ -69,3 +69,11 @@
>>  &uart6 {
>>       status = "okay";
>>  };
>> +
>> +&spi2 {
>> +     status = "okay";
>> +};
>> +
>> +&spi3 {
>> +     status = "okay";
>
> LS connector label?

Thanks Rob. I will fix that, adding label accordingly.
