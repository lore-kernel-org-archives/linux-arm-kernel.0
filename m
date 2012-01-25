From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Wed, 25 Jan 2012 16:20:31 +0530
Subject: [alsa-devel] [PATCH v4 - resend 00/13] OMAP4: ASoC: Support for
 PandaBoard family
In-Reply-To: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com>
References: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <CAJe_Zhfn3urdXfRgAKvdW2_ECYGbNO0b2BuZnCZxrGcL4_sVSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 January 2012 17:22, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> Hello,
>
> the following series will add ASoC support for PandaBoards.
> PandaBoards have different audio routings compared to SDP4430/Blaze boards, but
> the differences not that big to justify a new ASoC machine driver.
>
> The v3 series did not made it to 3.3 kernel.
> This set contains all the patches needed to enable the audio support on the
> PandaBoard family.
> The machine driver has been converted to a generic OMAP4 driver which can
> support wide range of machines using OMAP4 with twl6040 codec.
>
> I have remove the hardcoded MCLK clock frequency use in the machine driver
> (there can be devices with different MCLK configuration). This changed
> patch 04, 05, and 12. Since this does not affect the functionality I kept the
> acks for these patches. Patch 11 did not existed in the v3 series.
>
Hi Peter,
   I tried the patchset on my 4430 Panda. Playback works ok, but not Capture.
All is get is a hiss.
  Is capture supposed to work ? If yes, any amixer settings that need
to be done?

Thanks,
-Jassi
