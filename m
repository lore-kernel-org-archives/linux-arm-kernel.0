From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Thu, 18 Jun 2015 15:55:32 -0700
Subject: [PATCH 1/2] clk: keystone: add support for post divider register
 for main pll
In-Reply-To: <20150618223728.9112.75331@quantum>
References: <1432915453-409-1-git-send-email-m-karicheri2@ti.com>
 <20150618223728.9112.75331@quantum>
Message-ID: <55834C64.6020703@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/18/2015 3:37 PM, Michael Turquette wrote:
> Quoting Murali Karicheri (2015-05-29 09:04:12)
>> Main PLL controller has post divider bits in a separate register in
>> pll controller. Use the value from this register instead of fixed
>> divider when available.
>>
>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>
> Applied to clk-next.
>
Thanks Mike !!
