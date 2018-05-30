From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Wed, 30 May 2018 10:38:23 +0300
Subject: [PATCH v3 3/5] Documentation: DT: add i.MX EPIT timer binding
In-Reply-To: <7f2f8b6b-b7f6-99c1-fc5f-a7628a751fdc@mentor.com>
References: <20180529170436.22711-1-peron.clem@gmail.com>
 <20180529170436.22711-4-peron.clem@gmail.com>
 <7f2f8b6b-b7f6-99c1-fc5f-a7628a751fdc@mentor.com>
Message-ID: <5d71aced-cd2f-3f01-25b0-d87788f22c32@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/30/2018 10:27 AM, Vladimir Zapolskiy wrote:
> Hi Cl?ment,
> 
> On 05/29/2018 08:04 PM, Cl?ment P?ron wrote:
>> From: Cl?ment Peron <clement.peron@devialet.com>
>>
>> Add devicetree binding document for NXP's i.MX SoC specific
>> EPIT timer driver.
>>
>> Signed-off-by: Cl?ment Peron <clement.peron@devialet.com>
>> ---
>>  .../devicetree/bindings/clock/imx6q,epit.txt  | 24 +++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/imx6q,epit.txt
>>
>> diff --git a/Documentation/devicetree/bindings/clock/imx6q,epit.txt b/Documentation/devicetree/bindings/clock/imx6q,epit.txt
>> new file mode 100644
>> index 000000000000..a84a60c6ae35
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/imx6q,epit.txt
> 
> The file should be renamed to a more generic name like 'imx,epit.txt'
> or 'imx31,epit.txt'.
> 
> Also note that the folder is incorrectly selected, it must be
> Documentation/devicetree/bindings/timer/
> 

And linux-clk mailing list for publishing seems to be improper one,
instead please add Daniel Lezcano <daniel.lezcano@linaro.org> and
Thomas Gleixner <tglx@linutronix.de> to the list of addressees,
and the proper mailing list address is linux-kernel at vger.kernel.org

--
With best wishes,
Vladimir
