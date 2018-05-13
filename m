From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sun, 13 May 2018 17:34:42 +0300
Subject: [PATCH v3 1/3] leds: triggers: provide
 led_trigger_register_format()
In-Reply-To: <20180510112229.GE6977@amd>
References: <20180508100543.12559-1-u.kleine-koenig@pengutronix.de>
 <20180508100543.12559-2-u.kleine-koenig@pengutronix.de>
 <20180510112101.GD6977@amd> <20180510112229.GE6977@amd>
Message-ID: <CAHp75VeWsbT+XuacdrKM6drzcxwx0inAUjtyU0WBX_SUTg6Lbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2018 at 2:22 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Thu 2018-05-10 13:21:01, Pavel Machek wrote:

>> I know this is not your fault, but if you have a space or "[]" in
>> netdev names, confusing things will happen.
>
> Hmm. If we are doing this we really should check trigger names for
> forbidden characters. At least "[] " should be forbidden.

So, string_escape_mem() is your helper here.

-- 
With Best Regards,
Andy Shevchenko
