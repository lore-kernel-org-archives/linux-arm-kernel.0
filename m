From: acourbot@nvidia.com (Alex Courbot)
Date: Wed, 20 Mar 2013 11:24:48 +0900
Subject: [PATCH V4 0/9] Add mandatory regulator for all users of
 pwm-backlight.
In-Reply-To: <20130320021442.GB20443@S2101-09.ap.freescale.net>
References: <1363719573-20926-1-git-send-email-achew@nvidia.com>
 <20130320021442.GB20443@S2101-09.ap.freescale.net>
Message-ID: <51491DF0.10408@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/20/2013 11:14 AM, Shawn Guo wrote:
> On Tue, Mar 19, 2013 at 11:59:24AM -0700, Andrew Chew wrote:
>> Many backlights are enabled via GPIO.  We can generalize the GPIO to a
>> fixed regulator.
>>
> I think we should push the series of "Runtime Interpreted Power
> Sequences" moving forward, which should be useful this case and many
> other cases as well.
>
> http://thread.gmane.org/gmane.linux.kernel/1395912

That's still the medium-term plan. But doing this correctly requires 
some improvements to be done in the GPIO subsystem, which I am pushing 
at the moment.

Eventually power sequences should handle this kind of scenario, but by 
the meantime it cannot hurt to get the job done.

Alex.
