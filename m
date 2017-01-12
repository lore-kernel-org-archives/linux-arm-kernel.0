From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 11 Jan 2017 17:29:41 -0800
Subject: [PATCH 56/62] watchdog: tangox_wdt: Convert to use device managed
 functions
In-Reply-To: <CAHp75VfUUJaCLXgZ+jNj18ZEMXSNnaw6UvEZcuP7J22apojPYQ@mail.gmail.com>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-5-git-send-email-linux@roeck-us.net>
 <bd56e90c-5cb8-02d8-3518-c8f5483a6df4@sigmadesigns.com>
 <94c4d5c0-f639-eab1-6706-335977690e88@roeck-us.net>
 <CAHp75VfUUJaCLXgZ+jNj18ZEMXSNnaw6UvEZcuP7J22apojPYQ@mail.gmail.com>
Message-ID: <0c2648fd-ccf2-c7cf-6c7a-1519bf7e035f@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2017 04:12 PM, Andy Shevchenko wrote:
> On Wed, Jan 11, 2017 at 12:52 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 01/11/2017 01:07 AM, Marc Gonzalez wrote:
>> Not really. It would just make it more complicated to replace the
>> call with devm_clk_prepare_enable(), should it ever find its way
>> into the light of day.
> Actually what is the status to the patch series which brings devm_clk
> stuff like prepare_enable()? It was submitted 2(?) years ago.
>

It stalled.

Guenter
