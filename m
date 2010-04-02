From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 2 Apr 2010 11:24:20 -0500
Subject: [PATCH] arm: ARCH_REQUIRE_GPIOLIB selects GENERIC_GPIO
In-Reply-To: <z2of17812d71004020155kb2e4c34ds97391c04b4848640@mail.gmail.com>
References: <0D753D10438DA54287A00B0270842697636A7E9494@AUSP01VMBX24.collaborationhost.net>
	<z2of17812d71004020155kb2e4c34ds97391c04b4848640@mail.gmail.com>
Message-ID: <0D753D10438DA54287A00B0270842697636A7E98EB@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, April 02, 2010 1:55 AM, Eric Miao wrote:
> On Fri, Apr 2, 2010 at 6:32 AM, H Hartley Sweeten <hartleys@visionengravers.com> wrote:
>> The ARCH_REQUIRE_GPIOLIB config option will select GPIOLIB which
>> in turn will select GENERIC_GPIO. ?Because of this, there is no
>> reason to do the select GENERIC_GPIO in arch/arm/Kconfig for the
>> architectures that have ARCH_REQUIRE_GPIOLIB.
>>
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>>
>
> A clean removal, Acked-by: Eric Miao <eric.y.miao@gmail.com>

Thanks.

Your reply was just to me.  This is just to make sure it's on the arm list.

Regards,
Hartley
