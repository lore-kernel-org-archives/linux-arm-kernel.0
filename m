From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 29 Oct 2014 11:53:38 +0100
Subject: [PATCH v5 3/4] regulator: max77686: Add suspend disable for some
 LDOs
In-Reply-To: <5450C6C2.2050506@collabora.co.uk>
References: <1414411911-5539-1-git-send-email-k.kozlowski@samsung.com>
 <1414411911-5539-4-git-send-email-k.kozlowski@samsung.com>
 <20141028223121.GH18557@sirena.org.uk> <1414574413.18868.6.camel@AMDC1943>
 <20141029100142.GR18557@sirena.org.uk> <1414577934.18868.7.camel@AMDC1943>
 <20141029103140.GY18557@sirena.org.uk> <1414579442.18868.13.camel@AMDC1943>
 <5450C6C2.2050506@collabora.co.uk>
Message-ID: <1414580018.18868.14.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ?ro, 2014-10-29 at 11:51 +0100, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 10/29/2014 11:44 AM, Krzysztof Kozlowski wrote:
> > On ?ro, 2014-10-29 at 10:31 +0000, Mark Brown wrote:
> >> On Wed, Oct 29, 2014 at 11:18:54AM +0100, Krzysztof Kozlowski wrote:
> >> > On ?ro, 2014-10-29 at 10:01 +0000, Mark Brown wrote:
> >> 
> >> > > No, this isn't suspend enable control - this is normal, standard enable
> >> > > control and the device has no suspend enable control.
> >> 
> >> > You mean that for such regulator the driver shouldn't implement
> >> > suspend_enable()?
> >> 
> >> Yes, if there is no separate control of suspend mode in hardware then of
> >> course the driver shouldn't implement operations for things it doesn't
> >> have.
> > 
> > Oh, thanks! I'll send fixed patch.
> > 
> > This means that probably the max77802 ("mirrored" driver) should be
> > fixed...
> > 
> 
> Indeed, I had the same confusion that you had. Just to avoid duplicating work,
> do you want me to send a fix or are you going to include one on your series?

I'll send a patch for max77802 also.

Best regards,
Krzysztof
