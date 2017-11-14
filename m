From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 14 Nov 2017 08:13:14 -0200
Subject: DryIce , RTC not working on imx53.
In-Reply-To: <D24E577EA1E37B4788A3BFBC418F14A707646377@wetsrvex01.loepfe.com>
References: <D24E577EA1E37B4788A3BFBC418F14A70760C04A@wetsrvex01.loepfe.com>
 <3BB206AB2B1BD448954845CE6FF69A8E01B8E754AA@NT-Mail07.beckhoff.com>
 <20171109030327.anzo47xayxckn47r@piout.net>
 <3BB206AB2B1BD448954845CE6FF69A8E01CB52290E@NT-Mail07.beckhoff.com>
 <20171113161522.2kq7un7gl5vg4qlq@piout.net>
 <CAOMZO5Bi5PcuGiVRZykw9Zp-ysHmHzThhwNai-cqy3HRTUKQAg@mail.gmail.com>
 <CAOMZO5AOAo8OU86CrneFeWuu2ti1sea9843UQ16=7AyU5-B11Q@mail.gmail.com>
 <3BB206AB2B1BD448954845CE6FF69A8E01CB52F4BE@NT-Mail07.beckhoff.com>
 <D24E577EA1E37B4788A3BFBC418F14A707646377@wetsrvex01.loepfe.com>
Message-ID: <CAOMZO5BqhhFMRByY+cHXcqmUiLVVngYHvjmTcNJP8M08ew8xnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Noel,

On Tue, Nov 14, 2017 at 4:40 AM, Vellemans, Noel
<Noel.Vellemans@visionbms.com> wrote:
> HI all,
>
> I've been digging a while in the DryIce code (some time ago, it was in a hurry because I needed to release).
>
> I finally ended up by NOT using the DryIce code , for the IMX53 ( internal RTC)
>
> If I recall correctly , this is not the correct driver for the Internal IMX53 RTC, ( for example the register BASE-Addresses / offsets are not correct..)
> resulting in all kind of strange behavior, depending on your situational use-cases:-(

Could you clarify about this? Which base address or offsets are not correct?
