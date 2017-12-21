From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Dec 2017 16:27:28 +0100
Subject: [PATCH] ARM: dts: aspeed-g4: Correct VUART IRQ number
In-Reply-To: <6c68ec45-a0d8-f601-08e3-c21db0b8f925@kaod.org>
References: <20171215053332.31690-1-joel@jms.id.au>
 <6c68ec45-a0d8-f601-08e3-c21db0b8f925@kaod.org>
Message-ID: <CAK8P3a18QJiL66D9oTgJYjX1zwNmY7DOzd20QJqTMb3CE1-dsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 18, 2017 at 10:00 AM, C?dric Le Goater <clg@kaod.org> wrote:
> On 12/15/2017 06:33 AM, Joel Stanley wrote:
>> This should have always been 8.
>>
>> Fixes: db4d6d9d80fa ("ARM: dts: aspeed: Correctly order UART nodes")
>> Cc: stable at vger.kernel.org
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>
> Reviewed-by: C?dric Le Goater <clg@kaod.org>
>
>> ---
>> ARM maintainers, please include this fix for 4.15

Applied to fixes, thanks!

      Arnd
