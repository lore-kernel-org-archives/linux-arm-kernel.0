From: carlo@caione.org (Carlo Caione)
Date: Fri, 19 Sep 2014 10:07:51 +0200
Subject: [PATCH v2 1/4] ARM: docs: add documentation binding for meson
 watchdog
In-Reply-To: <20140917205827.GA5269@gmail.com>
References: <1410984726-18944-1-git-send-email-carlo@caione.org>
 <1410984726-18944-2-git-send-email-carlo@caione.org>
 <20140917205827.GA5269@gmail.com>
Message-ID: <CAOQ7t2Y4JAvs97UYONd1K3Lchps8w+RqavnT0D1R8gbgrCVd6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 17, 2014 at 10:58 PM, Beniamino Galvani <b.galvani@gmail.com> wrote:
> On Wed, Sep 17, 2014 at 10:12:03PM +0200, Carlo Caione wrote:
>> Signed-off-by: Carlo Caione <carlo@caione.org>
>> ---
>>  Documentation/devicetree/bindings/watchdog/meson-wdt.txt | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/watchdog/meson-wdt.txt
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/meson-wdt.txt b/Documentation/devicetree/bindings/watchdog/meson-wdt.txt
>> new file mode 100644
>> index 0000000..e66c0c3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/watchdog/meson-wdt.txt
>> @@ -0,0 +1,13 @@
>> +Meson SoCs Watchdog timer
>> +
>> +Required properties:
>> +
>> +- compatible : should be "amlogic,meson-wdt"
>
> Hi Carlo,
>
> the compatible property should describe a specific version of the
> device, so maybe "amlogic,meson6-wdt" would be more appropriate.

Agree. Fix in v3.

Thanks,

-- 
Carlo Caione
