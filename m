From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Fri, 31 Jul 2015 08:30:44 -0700
Subject: [PATCH 2/2] ARM: dts: keystone: fix dt bindings to use post div
 register for mainpll
In-Reply-To: <55BB8412.2000905@ti.com>
References: <1432915453-409-1-git-send-email-m-karicheri2@ti.com>
 <1432915453-409-2-git-send-email-m-karicheri2@ti.com>
 <55BB8412.2000905@ti.com>
Message-ID: <55BB94A4.1010200@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/31/2015 7:20 AM, Murali Karicheri wrote:
> On 05/29/2015 12:04 PM, Murali Karicheri wrote:
>> All of the keystone devices have a separate register to hold post
>> divider value for main pll clock. Currently the fixed-postdiv
>> value used for k2hk/l/e SoCs works by sheer luck as u-boot happens to
>> use a value of 2 for this. Now that we have fixed this in the pll
>> clock driver change the dt bindings for the same.
>>
>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>> ---

[..]

> Santosh,
>
> The clk driver update is already merged to v4.2-rc. Could you send this
> DT update as well for 4.2-rc?
>
Sure.

Regards,
Santosh
