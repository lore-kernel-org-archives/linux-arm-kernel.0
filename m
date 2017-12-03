From: peda@axentia.se (Peter Rosin)
Date: Sun, 3 Dec 2017 07:59:04 +0100
Subject: [PATCH 1/2] dt-bindings: trivial: add tfa9879 device
In-Reply-To: <CAOMZO5BA2ZbBnPVORALkEGV21j7H9GJW_2uVvtEEU=8qM599-w@mail.gmail.com>
References: <20171201224425.5477-1-peda@axentia.se>
 <20171201224425.5477-2-peda@axentia.se>
 <CAOMZO5BA2ZbBnPVORALkEGV21j7H9GJW_2uVvtEEU=8qM599-w@mail.gmail.com>
Message-ID: <8e295c61-089e-170d-bca2-42ded2021c99@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-12-02 22:17, Fabio Estevam wrote:
> On Fri, Dec 1, 2017 at 8:44 PM, Peter Rosin <peda@axentia.se> wrote:
>> Add record for NXP TFA9879 Mono BTL Class D audio amplifier.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  Documentation/devicetree/bindings/trivial-devices.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
>> index af284fbd4d23..4cf30ce4e71f 100644
>> --- a/Documentation/devicetree/bindings/trivial-devices.txt
>> +++ b/Documentation/devicetree/bindings/trivial-devices.txt
>> @@ -157,6 +157,7 @@ nxp,pcf2127         Real-time clock
>>  nxp,pcf2129            Real-time clock
>>  nxp,pcf8563            Real-time clock/calendar
>>  nxp,pcf85063           Tiny Real-Time Clock
>> +nxp,tfa9879            Mono BTL Class D audio amplifier
> 
> This is already described at Documentation/devicetree/bindings/sound/tfa9879.txt

Right. However, the patch adding that should have been sent to me, the
maintainer of the driver. That is carefully recorded in MAINTAINERS. So,
forgive me for assuming that nothing had changed in the driver behind my
back.

Had that patch been sent my way as it should have been, I would have
insisted that maintenance of the bindings had been kept together with
the maintenance of the driver.

Cheers,
Peter
