From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 12 Nov 2012 20:09:54 -0200
Subject: [PATCH] ARM: boot: Fix usage of kecho
In-Reply-To: <201210241928.34303.arnd@arndb.de>
References: <1351103848-30900-1-git-send-email-festevam@gmail.com>
 <alpine.LFD.2.02.1210241444090.16518@xanadu.home>
 <201210241928.34303.arnd@arndb.de>
Message-ID: <CAOMZO5BEi7n76roOAgBFEqvqJybsCeGKZuozqYL5PRL3hJnghQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, Oct 24, 2012 at 5:28 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 24 October 2012, Nicolas Pitre wrote:
>> On Wed, 24 Oct 2012, Fabio Estevam wrote:
>>
>> > From: Fabio Estevam <fabio.estevam@freescale.com>
>> >
>> > Since commit edc88ceb0 (ARM: be really quiet when building with 'make -s') the
>> > following output is generated when building a kernel for ARM:
>> >
>> > echo '  Kernel: arch/arm/boot/Image is ready'
>> >   Kernel: arch/arm/boot/Image is ready
>> >   Building modules, stage 2.
>> > echo '  Kernel: arch/arm/boot/zImage is ready'
>> >   Kernel: arch/arm/boot/zImage is ready
>> >
>> > As per Documentation/kbuild/makefiles.txt the correct way of using kecho is
>> > '@$(kecho)'.
>> >
>> > Make this change so no more unwanted 'echo' messages are displayed.
>> >
>> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> Acked-by: Nicolas Pitre <nico@linaro.org>
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Would this one go via arm-soc tree?

Regards,

Fabio Estevam
