From: olof@lixom.net (Olof Johansson)
Date: Wed, 1 Apr 2015 15:57:34 -0700
Subject: [PATCH v6 5/6] ARM: dts: Alpine platform devicetree
In-Reply-To: <20150401225609.GG24899@n2100.arm.linux.org.uk>
References: <55017e28.Jzshpkksg8eI/q72%tsahee@annapurnalabs.com>
 <20150401225609.GG24899@n2100.arm.linux.org.uk>
Message-ID: <CAOesGMhFRXF6WPYMHSMQFQUaMXdXowok2gwi+_UMwrr7fveqAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Apr 1, 2015 at 3:56 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Can we please get this patch reverted, or at least fixed - preferably
> before the merge window opens!
>
>> +dtb-$(CONFIG_ARCH_ALPINE) += alpine_db.dtb
>
> Here, the filename contains an underscore.
>
>> diff --git a/arch/arm/boot/dts/alpine-db.dts b/arch/arm/boot/dts/alpine-db.dts
>> new file mode 100644
>> index 0000000..dfb5a08
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/alpine-db.dts
>
> Here, the filename contains a hyphen.
>
> Hence, when building a kernel with ARCH_ALPINE enabled, it fails to build,
> and this screws up an otherwise fine allmodconfig build.

Yeah, I'll fix it up today. Apologies for not getting to it earlier (I
know you reported it in person).


-Olof
