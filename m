From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Thu, 12 Jan 2017 02:12:39 +0200
Subject: [PATCH 56/62] watchdog: tangox_wdt: Convert to use device managed
 functions
In-Reply-To: <94c4d5c0-f639-eab1-6706-335977690e88@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-5-git-send-email-linux@roeck-us.net>
 <bd56e90c-5cb8-02d8-3518-c8f5483a6df4@sigmadesigns.com>
 <94c4d5c0-f639-eab1-6706-335977690e88@roeck-us.net>
Message-ID: <CAHp75VfUUJaCLXgZ+jNj18ZEMXSNnaw6UvEZcuP7J22apojPYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 12:52 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 01/11/2017 01:07 AM, Marc Gonzalez wrote:
> Not really. It would just make it more complicated to replace the
> call with devm_clk_prepare_enable(), should it ever find its way
> into the light of day.
Actually what is the status to the patch series which brings devm_clk
stuff like prepare_enable()? It was submitted 2(?) years ago.

-- 
With Best Regards,
Andy Shevchenko
