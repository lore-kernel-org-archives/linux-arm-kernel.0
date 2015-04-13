From: k.kozlowski.k@gmail.com (=?UTF-8?Q?Krzysztof_Koz=C5=82owski?=)
Date: Mon, 13 Apr 2015 19:54:40 +0900
Subject: [PATCH 0/7] ARM: dts: Refactor Exynos5 boards for phandle notation
In-Reply-To: <2603418.sEMfdEBYRq@wuerfel>
References: <1428841494-20769-1-git-send-email-k.kozlowski.k@gmail.com>
 <2603418.sEMfdEBYRq@wuerfel>
Message-ID: <CAJKOXPekqfWn0E8R2NWgS656mcBjiAzOeoLvMEx=vbnAyupF-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-04-13 5:07 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Sunday 12 April 2015 21:24:47 Krzysztof Kozlowski wrote:
>>
>> The phandle notation reduces possible mistakes when overriding nodes
>> by child board files and reduces duplication of addresses.
>>
>> The patchset refactors Exynos5 boards to use the phandle way.
>>
>> Tested by comparison of decompiled DTB for each commit.
>
> The patches look fine, but the description is wrong as you are not
> using 'phandles' here, you are using 'labels'.

Heh, I suspected this but some docs I found referred to "&label { ...
}" also as a phandle. Thanks for pointing this out. I'll respin.

Best regards,
Krzysztof
