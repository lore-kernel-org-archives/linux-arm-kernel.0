From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Thu, 3 Aug 2017 20:11:32 +0300
Subject: [PATCH 0/6] Support for LEGO MINDSTORMS EV3 LCD display
In-Reply-To: <CAHp75Vdaq0ersEa2_XneUQtsJMj2GCRZL4Wi=1HQorLkb4SaVg@mail.gmail.com>
References: <1501355870-13960-1-git-send-email-david@lechnology.com>
 <5d8f6518-8d7e-c029-2da4-e3417afb3e40@lechnology.com>
 <28188f5c-1daf-121b-6daf-1899668c3875@tronnes.org>
 <1ce36d43-b9dd-807e-23aa-bac4fda70fdc@lechnology.com>
 <bfb3d541-856b-0233-dd85-72512788939f@tronnes.org>
 <bbec0574-311a-e1b4-d7fd-f6fb15b078d2@lechnology.com>
 <b8ec0511-afd1-2a1b-6ffe-dfe951d79bf7@tronnes.org>
 <cf740449-c952-08d4-d63c-d92e71fa3092@lechnology.com>
 <CAHp75Vdaq0ersEa2_XneUQtsJMj2GCRZL4Wi=1HQorLkb4SaVg@mail.gmail.com>
Message-ID: <CAHp75Vf2GVASatG_aJrBPNHR-jQLoYtOPan5ezcoWRDuEsXbNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 3, 2017 at 8:09 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Aug 3, 2017 at 6:18 PM, David Lechner <david@lechnology.com> wrote:
>
>> The particular display I have is this one:
>> http://wiki.seeed.cc/Grove-OLED_Display_1.12inch/
>>
>> It looks like it uses a command/data scheme like the MIPI displays, but
>> doesn't use any of the standard values for the commands. The controller can
>> do parallel, SPI and I2C, but the display I have is wired for I2C.
>
> It looks very similar to ssd1306. Some description refers to ssd1308.

http://www.mouser.com/catalog/specsheets/Seeed_104030008.pdf


-- 
With Best Regards,
Andy Shevchenko
