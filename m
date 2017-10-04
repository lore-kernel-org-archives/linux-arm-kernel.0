From: itaru.kitayama@riken.jp (Itaru Kitayama)
Date: Wed, 4 Oct 2017 22:12:09 +0900
Subject: defconfig'ed v4.13 does not boot on ThunderX
In-Reply-To: <CAKv+Gu_FHVrKpCbLm3iukaB79cypO-erQYrK6gmhpMyL0yCaUA@mail.gmail.com>
References: <135495b6-e13e-5c90-6130-addb60d0fa5c@riken.jp>
 <20171004100641.GA23092@leverpostej>
 <90797628-6432-f38b-88c9-6f544f237a5f@riken.jp>
 <CAKv+Gu_FHVrKpCbLm3iukaB79cypO-erQYrK6gmhpMyL0yCaUA@mail.gmail.com>
Message-ID: <e8c71230-1c1e-f347-9f34-0c81a164933d@riken.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Booting up together also with acpi=force did nothing.

On 2017/10/04 21:53, Ard Biesheuvel wrote:
> On 4 October 2017 at 13:49, Itaru Kitayama <itaru.kitayama@riken.jp> wrote:
>> Mark,
>> I tried to bring up it adding earlycon=p1011,0x87e024000000
>> but no luck. Not sure if that's the right value to feed either though.
>>
> 
> Please try just 'earlycon' without = or any arguments, and if that
> does not work, use pl011 not p1011 (L not 1)
> 
