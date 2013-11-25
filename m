From: ivan.khoronzhuk@ti.com (ivan.khoronzhuk)
Date: Mon, 25 Nov 2013 15:19:56 +0200
Subject: [PATCH v2 0/6] Update Davinci watchdog driver
In-Reply-To: <52934B6C.4060308@ti.com>
References: <1384795139-19466-1-git-send-email-ivan.khoronzhuk@ti.com>
 <52934B6C.4060308@ti.com>
Message-ID: <52934E7C.9040102@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25/2013 03:06 PM, Sekhar Nori wrote:
> On Monday 18 November 2013 10:48 PM, Ivan Khoronzhuk wrote:
>> These patches are intended to update Davinci watchdog to use WDT core
>> and reuse driver for keystone arch, because Keystone uses the similar
>> IP like Davinci.
>
> This series causes a regression on all DaVinci platforms because after
> the series is applied the watchdog device does not get registered at
> all. Since you changed the device name please include a patch to fix the
> platform references too.
>
> Thanks,
> Sekhar
>

Ok, I will replace

-- 
Regards,
Ivan Khoronzhuk
