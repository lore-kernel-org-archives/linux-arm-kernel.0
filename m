From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 28 Apr 2014 13:11:20 +0200
Subject: [PATCH 21/38] mmc: sdhci: hack up driver to make it more
 compliant with UHS-1
In-Reply-To: <20140428110259.GI26756@n2100.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
 <E1Wd2WT-0003vg-Ke@rmk-PC.arm.linux.org.uk>
 <20140425123820.GA15179@pengutronix.de>
 <CAPDyKFpja-dGwsEL6YP=Nn=YSRRgMzTTz6WVQ8DiUOMrkLJpBQ@mail.gmail.com>
 <20140428110259.GI26756@n2100.arm.linux.org.uk>
Message-ID: <CAPDyKFpHoLbY4Li45UfPweJ0xKpa5E5d=YX+Sgz9pvRG4W2xiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 April 2014 13:02, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Mon, Apr 28, 2014 at 12:50:54PM +0200, Ulf Hansson wrote:
>> On 25 April 2014 14:38, Markus Pargmann <mpa@pengutronix.de> wrote:
>> > Hi,
>> >
>> > On Wed, Apr 23, 2014 at 08:07:57PM +0100, Russell King wrote:
>> >> Patch suggested by Dong Aisheng <dongas86@gmail.com>, this avoids
>> >> additional clock start/stop cycles during the transition to 1.8V
>> >> signalling mode.
>> >>
>> >> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> >
>> > I tested the series on imx6s with a RIoT board. With this patch applied
>> > the RIoT board emmc does not work. Here is the output of the board:
>>
>> Hi Markus,
>>
>> Thanks for helping out testing!
>>
>> Does that mean patch 1->20 works fine for you? May I add your tested-by tag?
>
> Why should _you_ add someone elses tested-by tag to _my_ patches?
>
> I still wonder whether you understood anything that I've already said to
> you about the handling of this patch set.

That was based upon that _I_ would help out in creating the pull
request to Chris, to minimize his effort in resolving conflicts.

All-right, I back off - I was just trying to help here. Please send
the pull request to Chris directly instead.

Kind regards
Ulf Hansson

>
> --
> FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
> improving, and getting towards what was expected from it.
