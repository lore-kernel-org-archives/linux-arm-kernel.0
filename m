From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Nov 2017 13:48:52 +0100
Subject: [PATCH v2 0/6] ARM: ep93xx: ts72xx: Add support for BK3 board
In-Reply-To: <20171129104545.0c03e766@jawa>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171121143204.1839-1-lukma@denx.de>
 <20171129104545.0c03e766@jawa>
Message-ID: <CAK8P3a0gEam9QGhyop-J0RPBB=yo6LFF8uaEnYLzrC_hzh_jKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 29, 2017 at 10:45 AM, Lukasz Majewski <lukma@denx.de> wrote:
> Dear All,
>
>> This patch series adds support for Liebherr's BK3 board, being
>> a derivative of TS72XX design.
>>
>> This patchset consists of following patches:
>>
>> - ts72xx.[c|h] cosmetic cleanup/improvement
>> - Rewrite ts72xx.c to be reusable by bk3
>> - The Liebherr's BK3 board has been added with re-using code of
>>   ts72xx.c
>>
>> This series applies on top of v4.14
>
> Do you have any comments regarding this patch series?

Looks all good to me.

      Arnd
