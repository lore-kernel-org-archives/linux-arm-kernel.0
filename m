From: m-karicheri2@ti.com (Murali Karicheri)
Date: Mon, 22 Jun 2015 16:15:26 -0400
Subject: [PATCH 1/2] clk: keystone: add support for post divider register
 for main pll
In-Reply-To: <55834C64.6020703@oracle.com>
References: <1432915453-409-1-git-send-email-m-karicheri2@ti.com>
 <20150618223728.9112.75331@quantum> <55834C64.6020703@oracle.com>
Message-ID: <55886CDE.7090906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2015 06:55 PM, santosh shilimkar wrote:
> On 6/18/2015 3:37 PM, Michael Turquette wrote:
>> Quoting Murali Karicheri (2015-05-29 09:04:12)
>>> Main PLL controller has post divider bits in a separate register in
>>> pll controller. Use the value from this register instead of fixed
>>> divider when available.
>>>
>>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>>
>> Applied to clk-next.
>>
> Thanks Mike !!
>
>
Thanks Mike.

Regards,

-- 
Murali Karicheri
Linux Kernel, Keystone
