From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 26 May 2015 15:36:04 +0200
Subject: [PATCH] ARM64: kasan: print memory assignment
In-Reply-To: <20150526094425.GD1565@arm.com>
References: <1432632464-12248-1-git-send-email-linus.walleij@linaro.org>
 <20150526094425.GD1565@arm.com>
Message-ID: <CACRpkdbVe9bY-iAxtnAh49bKKJu_Rmc-ovHoUjxnDM1+AcFTyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 26, 2015 at 11:44 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, May 26, 2015 at 10:27:44AM +0100, Linus Walleij wrote:
>> This prints out the virtual memory assigned to KASan in the
>> boot crawl along with other memory assignments, if and only
>> if KASan is activated.
>>
>> Example dmesg from the Juno Development board:
>>
>> Memory: 1691156K/2080768K available (5465K kernel code, 444K rwdata,
>> 2160K rodata, 340K init, 217K bss, 373228K reserved, 16384K cma-reserved)
>> Virtual kernel memory layout:
>>     kasan   : 0xffffff8000000000 - 0xffffff9000000000   (    64 MB)
>
> Unfortunately, that's a *lot* bigger than 64MB!

Grrr copy/paste error.

Thanks Will.

Linus Walleij
