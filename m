From: marek.belisko@gmail.com (Belisko Marek)
Date: Tue, 22 Jul 2014 21:51:04 +0200
Subject: [PATCH v2 2/7] arm: dts: omap3-gta04: Fix magnetometer model
In-Reply-To: <alpine.DEB.2.01.1407222145360.27558@pmeerw.net>
References: <1406057420-22269-1-git-send-email-marek@goldelico.com>
 <1406057420-22269-3-git-send-email-marek@goldelico.com>
 <alpine.DEB.2.01.1407222145360.27558@pmeerw.net>
Message-ID: <CAAfyv35OU5S9KKmOug99ByxghSa==emVzM85e33y84QvaRgBDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 22, 2014 at 9:46 PM, Peter Meerwald <pmeerw@pmeerw.net> wrote:
>
>> gta04 is using hmc5843l not hmc5843 so fix wrong compatible
>> entry.
>
> I guess you mean hmc5883l
Ah right. Thanks. I'll post update version.
>
>> Signed-off-by: Marek Belisko <marek@goldelico.com>
>> ---
>>  arch/arm/boot/dts/omap3-gta04.dts | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
>> index 7d7ddd7..6d1a8d8 100644
>> --- a/arch/arm/boot/dts/omap3-gta04.dts
>> +++ b/arch/arm/boot/dts/omap3-gta04.dts
>> @@ -220,7 +220,7 @@
>>
>>       /* compass aka magnetometer */
>>       hmc5843 at 1e {
>> -             compatible = "honeywell,hmc5843";
>> +             compatible = "honeywell,hmc5843l";
>>               reg = <0x1e>;
>>       };
>>
>>
>
> --
>
> Peter Meerwald
> +43-664-2444418 (mobile)

BR,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
