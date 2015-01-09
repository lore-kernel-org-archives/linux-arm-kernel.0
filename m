From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Fri, 9 Jan 2015 18:50:34 +0530
Subject: [PATCH v3 5/8] gpio: Add Fujitsu MB86S7x GPIO driver
In-Reply-To: <20150109125243.GM12302@n2100.arm.linux.org.uk>
References: <1420802369-3840-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1420803212-4350-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <20150109125243.GM12302@n2100.arm.linux.org.uk>
Message-ID: <CAJe_ZhdBCt0tLw7oU6fv7m_sBzB=nDhGWfbBFmpMMLOKiUuWrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 January 2015 at 18:22, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jan 09, 2015 at 07:33:32PM +0800, Vincent Yang wrote:
>> +static int mb86s70_gpio_remove(struct platform_device *pdev)
>> +{
>> +     struct mb86s70_gpio_chip *gchip = platform_get_drvdata(pdev);
>> +
>> +     gpiochip_remove(&gchip->gc);
>
> This doesn't disable and unprepare the clock.
>
Will do.

Thanks,
Jassi
