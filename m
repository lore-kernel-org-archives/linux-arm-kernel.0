From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 19 Aug 2013 16:56:19 -0600
Subject: [PATCH] i2c: move of helpers into the core
In-Reply-To: <3792014.HtzPVmLjnf@vostro.rjw.lan>
References: <1376918361-7014-1-git-send-email-wsa@the-dreams.de>
 <3792014.HtzPVmLjnf@vostro.rjw.lan>
Message-ID: <5212A293.2030903@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/19/2013 05:04 PM, Rafael J. Wysocki wrote:
> On Monday, August 19, 2013 03:19:18 PM Wolfram Sang wrote:
>> I2C of helpers used to live in of_i2c.c but experience (from SPI) shows
>> that it is much cleaner to have this in the core. This also removes a
>> circular dependency between the helpers and the core, and so we can
>> finally register child nodes in the core instead of doing this manually
>> in each driver. So, fix the drivers and documentation, too.
> 
> Perhaps we should do the analogous for ACPI then?
> 
> Rafael

Aargh. Why quote the entire patch just to say one line?
