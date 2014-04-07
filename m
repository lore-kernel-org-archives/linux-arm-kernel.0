From: elder@linaro.org (Alex Elder)
Date: Mon, 07 Apr 2014 06:58:42 -0500
Subject: drivers/clk/bcm/clk-bcm281xx.c breaks on GCC 4.6.4 (and earlier)
In-Reply-To: <20140407092609.GY7528@n2100.arm.linux.org.uk>
References: <20140407092609.GY7528@n2100.arm.linux.org.uk>
Message-ID: <534292F2.1040803@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/2014 04:26 AM, Russell King - ARM Linux wrote:
> So this greeted me this morning...

That sucks.

I don't see that, and I'm running 4.6.3.  (And I'm obviously
not testing with different versions of the compiler.)

I'll be investigating.

					-Alex


> drivers/clk/bcm/clk-bcm281xx.c:30:2: error: unknown field 'offset' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:30:2: error: unknown field 'shift' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:30:2: error: unknown field 'width' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:30:2: error: unknown field 'frac_width' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:30:2: error: unknown field 'scaled_div' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:51:2: error: unknown field 'offset' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:51:2: error: unknown field 'shift' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:51:2: error: unknown field 'width' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:51:2: error: unknown field 'scaled_div' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:59:2: error: unknown field 'offset' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:59:2: error: unknown field 'shift' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:59:2: error: unknown field 'width' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:59:2: error: unknown field 'scaled_div' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:83:2: error: unknown field 'offset' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:83:2: error: unknown field 'shift' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:83:2: error: unknown field 'width' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:83:2: error: unknown field 'scaled_div' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:95:2: error: unknown field 'offset' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:95:2: error: unknown field 'shift' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:95:2: error: unknown field 'width' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:95:2: error: unknown field 'scaled_div' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:107:2: error: unknown field 'offset' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:107:2: error: unknown field 'shift' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:107:2: error: unknown field 'width' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:107:2: error: unknown field 'scaled_div' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:119:2: error: unknown field 'offset' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:119:2: error: unknown field 'shift' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:119:2: error: unknown field 'width' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:119:2: error: unknown field 'scaled_div' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:128:2: error: unknown field 'fixed' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:140:2: error: unknown field 'fixed' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:147:2: error: unknown field 'offset' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:147:2: error: unknown field 'shift' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:147:2: error: unknown field 'width' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:147:2: error: unknown field 'scaled_div' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:151:2: error: unknown field 'fixed' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:164:2: error: unknown field 'offset' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:164:2: error: unknown field 'shift' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:164:2: error: unknown field 'width' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:164:2: error: unknown field 'frac_width' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:164:2: error: unknown field 'scaled_div' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:174:2: error: unknown field 'offset' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:174:2: error: unknown field 'shift' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:174:2: error: unknown field 'width' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:174:2: error: unknown field 'frac_width' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:174:2: error: unknown field 'scaled_div' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:184:2: error: unknown field 'offset' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:184:2: error: unknown field 'shift' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:184:2: error: unknown field 'width' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:184:2: error: unknown field 'frac_width' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:184:2: error: unknown field 'scaled_div' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:194:2: error: unknown field 'offset' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:194:2: error: unknown field 'shift' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:194:2: error: unknown field 'width' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:194:2: error: unknown field 'frac_width' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:194:2: error: unknown field 'scaled_div' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:206:2: error: unknown field 'offset' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:206:2: error: unknown field 'shift' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:206:2: error: unknown field 'width' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:206:2: error: unknown field 'scaled_div' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:218:2: error: unknown field 'offset' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:218:2: error: unknown field 'shift' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:218:2: error: unknown field 'width' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:218:2: error: unknown field 'scaled_div' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:260:2: error: unknown field 'offset' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:260:2: error: unknown field 'shift' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:260:2: error: unknown field 'width' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:260:2: error: unknown field 'scaled_div' specified in initializer
> make[4]: *** [drivers/clk/bcm/clk-bcm281xx.o] Error 1
> make[4]: Target `__build' not remade because of errors.
> make[3]: *** [drivers/clk/bcm] Error 2
> make[3]: Target `__build' not remade because of errors.
> make[2]: *** [drivers/clk] Error 2
> 
