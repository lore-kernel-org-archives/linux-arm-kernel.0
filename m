From: xuejiancheng@huawei.com (xuejiancheng)
Date: Mon, 11 Jan 2016 10:32:52 +0800
Subject: [PATCH v5 4/6] ARM: debug: add hi3519 debug uart
In-Reply-To: <20160108150828.GM19062@n2100.arm.linux.org.uk>
References: <1452219400-32478-1-git-send-email-xuejiancheng@huawei.com>
 <1452219400-32478-5-git-send-email-xuejiancheng@huawei.com>
 <20160108150828.GM19062@n2100.arm.linux.org.uk>
Message-ID: <56931454.6090300@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On 2016/1/8 23:08, Russell King - ARM Linux wrote:
> On Fri, Jan 08, 2016 at 10:16:38AM +0800, Jiancheng Xue wrote:
>> @@ -1449,6 +1457,7 @@ config DEBUG_UART_PHYS
>>  	default 0xf7fc9000 if DEBUG_BERLIN_UART
>>  	default 0xf8b00000 if DEBUG_HIX5HD2_UART
>>  	default 0xf991e000 if DEBUG_QCOM_UARTDM
>> +	default 0x12100000 if DEBUG_HI3519_UART
>>  	default 0xfcb00000 if DEBUG_HI3620_UART
>>  	default 0xfd883000 if DEBUG_ALPINE_UART0
>>  	default 0xfe800000 if ARCH_IOP32X
> 
> Please insert at the appropriate location - examination of the list
> of defaults will show that it's sorted numerically, please keep this
> sorted numerically.
> 

OK. Thank you!

>> @@ -1529,6 +1538,7 @@ config DEBUG_UART_VIRT
>>  	default 0xfe230000 if DEBUG_PICOXCELL_UART
>>  	default 0xfe300000 if DEBUG_BCM_KONA_UART
>>  	default 0xfe800000 if ARCH_IOP32X
>> +	default 0xfef00000 if DEBUG_HI3519_UART
>>  	default 0xfeb00000 if DEBUG_HI3620_UART || DEBUG_HIX5HD2_UART
>>  	default 0xfeb24000 if DEBUG_RK3X_UART0
>>  	default 0xfeb26000 if DEBUG_RK3X_UART1
> 
> Same for here.
> 
> Thanks.
> 
