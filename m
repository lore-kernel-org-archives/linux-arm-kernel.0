From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 29 Oct 2013 13:00:12 -0200
Subject: [PATCH v3] imx-drm: Add mx6 hdmi transmitter support
In-Reply-To: <20131028211945.GJ16735@n2100.arm.linux.org.uk>
References: <1382992009-19407-1-git-send-email-festevam@gmail.com>
 <20131028211945.GJ16735@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5BYXv4whoRrRD7pF5zj9DArEnbqFaZVdLgZgPC2nSDePw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 7:19 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Oct 28, 2013 at 06:26:49PM -0200, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> This is based on the initial work done by Sascha Hauer and Tony Prisk.
>
> It looks like you've also taken some of the suggestions I've made too -
> like the voltage drive and symbol transmit control settings.
>
> It would be nice to identify the changes a bit better so that those of
> us who are testing your drivers (and have patches on top of them to make
> things work) know what's changed.

Yes, I have been out the two past weeks and tried to capture all of
your inputs concerning the HDMI driver.

Today I was able to get access to a wandboard solo and the HDMI image
does look different compared to a wandboard quad board:

- The Linux logo penguins are steady on mx6q, but on mx6solo the
contour lines look like they flicker.
- The kernel log text appears in good white colour with mx6q, but not
so white on mx6solo (tending to green).

Even the U-boot HDMI splash screen is not very steady on mx6solo.

I will try to look at these mx6 solo HDMI issues.

Regards,

Fabio Estevam
