From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 14 Mar 2014 08:27:17 +0100
Subject: [PATCH] ARM: mach-ux500|nomadik|u300: Align to common DT bindings
 for mmci
In-Reply-To: <20140313174703.GO21483@n2100.arm.linux.org.uk>
References: <1394713963-18300-1-git-send-email-ulf.hansson@linaro.org>
 <20140313174703.GO21483@n2100.arm.linux.org.uk>
Message-ID: <CAPDyKFrw092mbirDBffF6TraUoXDLh5movp_sf9PYERG88P-Qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 March 2014 18:47, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Thu, Mar 13, 2014 at 01:32:43PM +0100, Ulf Hansson wrote:
>> As the first step in preparing the mmci driver for converting to the
>> mmc_of_parse API, let's align to the common names of DT bindings for
>> the mmc/sd highspeed modes.
>
> NAK.  These bindings have been documented as being there since March
> 14th 2012, and therefore need to be supported for ever by the driver.
> You can _augment_ the bindings with the generic ones, and change the
> DT files, but you can't remove the parsing of the old property names.

I was kind of expecting this response. :-)

So, since we made a mistake about adding these DT bindings we are now
unable to remove them, is there really no way back?

In this particular case, I am confident that it should be safe to
remove them, but I guess this is more matter of principle, right?

Kind regards
Ulf Hansson

>
> --
> FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
> improving, and getting towards what was expected from it.
