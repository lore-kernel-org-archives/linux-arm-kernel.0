From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Sun, 17 Mar 2013 16:32:30 +0100
Subject: [PATCH] ARM: mach-moxart: platform port for MOXA ART SoC
In-Reply-To: <201303151125.53999.arnd@arndb.de>
References: <CACmBeS1NLFUYHBOVL28aCCzRrgXYGPZF9t3qj6AdcgaMkrPGoQ@mail.gmail.com>
 <CACmBeS05cyT8N9nZeqbJUPMSGeZYLWjL0Tu1GSZ-ms+Hjc0UoQ@mail.gmail.com>
 <5140C6B2.7040702@gmail.com> <201303151125.53999.arnd@arndb.de>
Message-ID: <CACmBeS3aXs9vhc5ZYPbz5bjsYsSa6EzM12H4uPv706x0zU_5iw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thank you for the feedback.

Some of the changes are sure to be a challenge for me, but I want to
move this forward, and having a list helps.

3.2.40 is as far as it'll go right now, nothing prints to UART
starting with 3.3.8 (last tested, it's somewhere around there).

I have been advised to enable early_printk (by landley on freenode IRC #edev).

Best regards,
Jonas
