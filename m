From: carlo@caione.org (Carlo Caione)
Date: Sat, 20 Sep 2014 18:08:45 +0200
Subject: [PATCH v3 1/4] ARM: docs: add documentation binding for meson
 watchdog
In-Reply-To: <541D9D20.6080503@roeck-us.net>
References: <1411158989-8075-1-git-send-email-carlo@caione.org>
 <1411158989-8075-2-git-send-email-carlo@caione.org>
 <541D9D20.6080503@roeck-us.net>
Message-ID: <CAOQ7t2bBA3kW59z++Ewjch9+iTTzf7f0kE_9sytgLGqDAq3COQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 20, 2014 at 5:28 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 09/19/2014 01:36 PM, Carlo Caione wrote:
>>
>> Signed-off-by: Carlo Caione <carlo@caione.org>
>> ---
>>   Documentation/devicetree/bindings/watchdog/meson6-wdt.txt | 13
>> +++++++++++++
>>   1 file changed, 13 insertions(+)
>>   create mode 100644
>> Documentation/devicetree/bindings/watchdog/meson6-wdt.txt
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/meson6-wdt.txt
>> b/Documentation/devicetree/bindings/watchdog/meson6-wdt.txt
>> new file mode 100644
>> index 0000000..9200fc2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/watchdog/meson6-wdt.txt
>> @@ -0,0 +1,13 @@
>> +Meson SoCs Watchdog timer
>> +
>> +Required properties:
>> +
>> +- compatible : should be "amlogic,meson6-wdt"
>> +- reg : Specifies base physical address and size of the registers.
>> +
>
>
> The 'amlogic' vendor prefix is undefined.
> It will have to be added to
> Documentation/devicetree/bindings/vendor-prefixes.txt.

As stated in the cover, this patchset depends on
http://www.spinics.net/lists/arm-kernel/msg362521.html where the
vendor-prefixes.txt is updated.
Probably I should ping it.

-- 
Carlo Caione
