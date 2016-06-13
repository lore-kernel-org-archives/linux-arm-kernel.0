From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 13 Jun 2016 15:10:28 -0700
Subject: [PATCH v2 0/3] hw_random: Add Amlogic Meson SoCs Random Generator
 driver
In-Reply-To: <20160613123109.GA8674@gondor.apana.org.au> (Herbert Xu's message
 of "Mon, 13 Jun 2016 20:31:09 +0800")
References: <1465546915-24229-1-git-send-email-narmstrong@baylibre.com>
 <20160613123109.GA8674@gondor.apana.org.au>
Message-ID: <m2wplsviy3.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Herbert,

Herbert Xu <herbert@gondor.apana.org.au> writes:

> On Fri, Jun 10, 2016 at 10:21:52AM +0200, Neil Armstrong wrote:
>> Add support for the Amlogic Meson SoCs Hardware Random generator as a hw_random char driver.
>> The generator is a single 32bit wide register.
>> Also adds the Meson GXBB SoC DTSI node and corresponding DT bindings.
>> 
>> Changes since v1 at http://lkml.kernel.org/r/1464943621-18278-1-git-send-email-narmstrong at baylibre.com :
>> - change to depend on ARCH_MESON || COMPILE_TEST
>> - check buffer max size in read
>> 
>> Neil Armstrong (3):
>>   char: hw_random: Add Amlogic Meson Hardware Random Generator
>>   dt-bindings: hwrng: Add Amlogic Meson Hardware Random Generator
>>     bindings
>>   ARM64: dts: meson-gxbb: Add Hardware Random Generator node
>
> All applied.  Thanks.

Could you take just the driver please?

Due to lots of other activity in the DT, I'd prefer to send the DT &
bindings though the arm-soc (via the amlogic tree.)

Thanks,

Kevin
