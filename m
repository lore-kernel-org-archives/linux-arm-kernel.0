From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 5 Jun 2014 12:26:29 +0200
Subject: [PATCH v6 5/6] dt-bindings: add documentation for Mediatek SoC
In-Reply-To: <CAL_Jsq+jYZj_OcFkkBmpbGyEDKT7P_4Ek3os-qNFs9FfzxJvNw@mail.gmail.com>
References: <1401468964-5307-1-git-send-email-matthias.bgg@gmail.com>
 <1401468964-5307-6-git-send-email-matthias.bgg@gmail.com>
 <CAL_Jsq+jYZj_OcFkkBmpbGyEDKT7P_4Ek3os-qNFs9FfzxJvNw@mail.gmail.com>
Message-ID: <CABuKBe+rgPdCxQiDR34Cdb-mZKksbgLrEnHQre9PhgFY=WvrDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-06-03 14:51 GMT+02:00 Rob Herring <robherring2@gmail.com>:
> On Fri, May 30, 2014 at 11:56 AM, Matthias Brugger
> <matthias.bgg@gmail.com> wrote:
>> This adds a DT binding documentation for the MT6589 SoC from Mediatek.
>>
>> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
>> ---
>>  .../devicetree/bindings/arm/mediatek-mt65xx.txt    |    8 ++++++++
>
> How about just mediatek.txt? Otherwise:

You are right, I will fix this for v7 of the series.

>
> Acked-by: Rob Herring <robh@kernel.org>
>
> Rob
>
>>  1 file changed, 8 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek-mt65xx.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/mediatek-mt65xx.txt b/Documentation/devicetree/bindings/arm/mediatek-mt65xx.txt
>> new file mode 100644
>> index 0000000..d6ac71f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/mediatek-mt65xx.txt
>> @@ -0,0 +1,8 @@
>> +Mediatek MT6589 Platforms Device Tree Bindings
>> +
>> +Boards with a SoC of the Mediatek MT6589 shall have the following property:
>> +
>> +Required root node property:
>> +
>> +compatible: must contain "mediatek,mt6589"
>> +
>> --
>> 1.7.9.5
>>



-- 
motzblog.wordpress.com
