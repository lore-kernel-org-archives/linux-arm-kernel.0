From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 24 Sep 2012 08:59:47 -0700
Subject: [PATCH v4] hwmon: Versatile Express hwmon driver
In-Reply-To: <1348246591-2409-1-git-send-email-mail@pawelmoll.com>
References: <1348246591-2409-1-git-send-email-mail@pawelmoll.com>
Message-ID: <20120924155947.GA14060@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 05:56:31PM +0100, Pawel Moll wrote:
> From: Pawel Moll <pawel.moll@arm.com>
> 
> hwmon framework driver for Versatile Express sensors, providing
> information about board level voltage (only when regulator driver
> is not configured), currents, temperature and power/energy usage.
> Labels for the values can be defined as DT properties.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

After my concern was clarified ...

Acked-by: Guenter Roeck <linux@roeck-us.net>

I assume this will go upstream through the arm tree ?

Thanks,
Guenter
