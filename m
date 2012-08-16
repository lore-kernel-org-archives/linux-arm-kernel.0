From: jason77.wang@gmail.com (Hui Wang)
Date: Thu, 16 Aug 2012 14:48:00 +0800
Subject: [PATCH v3 2/3] Input: add devicetree binding note for egalax_ts
In-Reply-To: <20120815125353.GA2258@S2101-09.ap.freescale.net>
References: <1345026708-14139-1-git-send-email-jason77.wang@gmail.com>
 <1345026708-14139-2-git-send-email-jason77.wang@gmail.com>
 <1345026708-14139-3-git-send-email-jason77.wang@gmail.com>
 <20120815125353.GA2258@S2101-09.ap.freescale.net>
Message-ID: <502C97A0.2010902@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
> On Wed, Aug 15, 2012 at 06:31:47PM +0800, Hui Wang wrote:
>   
>> The egalax_ts driver needs to get the gpio number of the irq pin,
>> and use this gpio to wake up the controller. So add a note
>> for this change.
>>
>> Signed-off-by: Hui Wang <jason77.wang@gmail.com>
>> ---
>>  .../bindings/input/touchscreen/egalax-ts.txt       |   19 +++++++++++++++++++
>>  1 files changed, 19 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt
>>
>> diff --git a/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt b/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt
>> new file mode 100644
>> index 0000000..df70318
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt
>> @@ -0,0 +1,19 @@
>> +* EETI eGalax Multiple Touch Controller
>> +
>> +Required properties:
>> +- compatible: must be "eeti,egalax_ts"
>>     
>
> Since we define this in the binding anyway, can we have an corresponding
> .of_match_table in the driver?
>
> Regards,
> Shawn
>
>   
OK, will add it in the driver.

Regards,
Hui.
