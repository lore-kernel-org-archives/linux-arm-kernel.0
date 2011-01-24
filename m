From: khilman@ti.com (Kevin Hilman)
Date: Mon, 24 Jan 2011 14:17:29 -0800
Subject: [PATCH v4 0/6] OMAP: McSPI: Hwmod adaptation + runtime conversion
In-Reply-To: <1295358759-11731-1-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Tue, 18 Jan 2011 19:22:33 +0530")
References: <1295358759-11731-1-git-send-email-govindraj.raja@ti.com>
Message-ID: <87r5c254li.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

[...]

> Testing Updates:
> ----------------
> Was tested using data transfer test module available at:
> http://dev.omapzoom.org/?p=richo/device_driver_test.git;a=blob;f=mcspi/test_code/
> utils/mcspi_modules/omap_mcspi_datatest.c;
> h=e42ec10c5c844abdde6a7175a268b379fbbdb655;
> hb=5d9a755d50e58de861c5e8991f2f607bc49b5dc3
> This test basically involves MISO <--> MOSI lines looped and data transfer test
> done using the above test module.
> System wide suspend and ret/off counts observation, ensured that no behavioral
> difference with and without this patch series.

Can you also report what platforms this was tested on?

Thanks,

Kevin
