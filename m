From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 7 Apr 2015 06:17:05 -0600
Subject: [PATCH v2] coresight: adding basic support for Spreadtrum SC9836
In-Reply-To: <20150403195142.GR23023@localhost>
References: <1427287931-9363-1-git-send-email-zhang.chunyan@linaro.org>
 <20150403195142.GR23023@localhost>
Message-ID: <CANLsYkwSaJrTva-Gy7sr0-BU8Tz7Pq6Zwi1FCodBoY-G5xjNJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 April 2015 at 13:51, Olof Johansson <olof@lixom.net> wrote:
> On Wed, Mar 25, 2015 at 08:52:11PM +0800, Chunyan Zhang wrote:
>> Support only for ETF, FUNNEL, STM are included currently.
>> Support for ETM, TPIU and the replicator linked to it are not included in
>> this version patch.
>>
>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>> ---
>> Change for v2:
>>  - Corrected the TMC whose space is wrongly used as ETB in v1.
>>  - Removed "coresight-default-sink" from the DT.
>> ---
>
> Appled but with subject:
>
> arm64: dts: sprd: adding coresight entries to Spreadtrum SC9836
>
>

Olof,

I did not take this patch in my coresight tree yet as introduction of
the coresight STM driver and bindings in mainline has been delayed.
That patch should likely be reverted on your side and I'll take care
of it when we have a solution on the STM driver.

Thanks,
Mathieu

>
> -Olof
