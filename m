From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Wed, 20 Aug 2014 15:06:36 +0200
Subject: [PATCH v6 03/10] ARM: dts: Prepare node labels for exynos5250
In-Reply-To: <53DCE0F4.4060101@suse.de>
References: <1406940750-15880-1-git-send-email-afaerber@suse.de>
 <1406940750-15880-4-git-send-email-afaerber@suse.de>
 <53DCD74B.8090400@gmail.com> <53DCE0F4.4060101@suse.de>
Message-ID: <53F49D5C.4050007@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 02.08.2014 15:00, schrieb Andreas F?rber:
> Am 02.08.2014 14:19, schrieb Tomasz Figa:
>> Andreas,
>>
>> Ehh, one more thing. It looks like my memory is playing tricks on me.
>> Please see inline.
>>
>> On 02.08.2014 02:52, Andreas F?rber wrote:
>>> Allows them to be extended by reference.
>>>
>>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>>> ---
>>>  v6: Split off from Snow/SMDK cleanups (Doug Anderson)
>>
>> [snip]
>>
>>> -	serial at 12C00000 {
>>> +	uart0: serial at 12C00000 {
>>>  		clocks = <&clock CLK_UART0>, <&clock CLK_SCLK_UART0>;
>>>  		clock-names = "uart", "clk_uart_baud0";
>>>  	};
>>>  
>>> -	serial at 12C10000 {
>>> +	uart1: serial at 12C10000 {
>>>  		clocks = <&clock CLK_UART1>, <&clock CLK_SCLK_UART1>;
>>>  		clock-names = "uart", "clk_uart_baud0";
>>>  	};
>>>  
>>> -	serial at 12C20000 {
>>> +	uart2: serial at 12C20000 {
>>>  		clocks = <&clock CLK_UART2>, <&clock CLK_SCLK_UART2>;
>>>  		clock-names = "uart", "clk_uart_baud0";
>>>  	};
>>>  
>>> -	serial at 12C30000 {
>>> +	uart3: serial at 12C30000 {
>>>  		clocks = <&clock CLK_UART3>, <&clock CLK_SCLK_UART3>;
>>>  		clock-names = "uart", "clk_uart_baud0";
>>>  	};
>>
>> I forgot about a series [1] that went through tty tree, which is going
>> to conflict with this patch. It already adds labels to uart nodes in
>> serial_X format. I don't really remember why I went with this format for
>> Exynos SoCs and with uartX for older ones...
>>
>> [1]
>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/arch/arm/boot/dts?id=1e64f48ea7c59fb94acd7551dd9fa68b8a752efc
> 
> I doubt that I'll manage to resend another time today, [...]

Sorry, forgot about this. Done now. v7 as individual reply.

Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
