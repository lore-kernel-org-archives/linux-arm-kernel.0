From: carlo@caione.org (Carlo Caione)
Date: Tue, 3 Nov 2015 10:57:50 +0100
Subject: [PATCH v2 0/4] Add support for Amlogic Meson8b and couple of
 boards
In-Reply-To: <7134511.rF2lEWc2fm@wuerfel>
References: <1444249865-6897-1-git-send-email-carlo@caione.org>
 <7134511.rF2lEWc2fm@wuerfel>
Message-ID: <CAOQ7t2arq0U9E_epmAtBjs_MQuDgD2Z28txzRJT4UoLUiNnaow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 8, 2015 at 5:23 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 07 October 2015 22:31:01 Carlo Caione wrote:
>> From: Carlo Caione <carlo@endlessm.com>
>>
>> A patchset sitting in my personal repo since forever. It adds the basic support
>> for Amlogic Meson8B SoCs and two common boards: Hardkernel Odroid-C1 and Tronfy
>> MXQ.
>>
>> Changelog:
>> ** v2:
>>  - Specified which board compatibles apply to which SOC
>>  - Added commit message specifying who is Tronfy
>>
>> Carlo Caione (4):
>>   of: documentation: Add vendor prefix for Tronfy
>>   of: documentation: add bindings documentation for Meson8b
>>   ARM: meson: Add DTS for Odroid-C1 and Tronfy MXQ boards
>>   ARM: meson: Enable Meson8b SoCs
>>
>
> Applied to next/dt and next/soc, respectively, thanks!

Arnd,
Any idea why I don't see these in 4.3?

Thanks,

-- 
Carlo Caione
