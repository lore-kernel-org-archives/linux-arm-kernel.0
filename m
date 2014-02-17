From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 16 Feb 2014 23:11:40 -0300
Subject: [PATCH 1/2] ARM: dts: imx6qdl-sabresd: Add hog entry for GPIO4_10
In-Reply-To: <20140217020519.GC9879@S2101-09.ap.freescale.net>
References: <1392306839-10736-1-git-send-email-fabio.estevam@freescale.com>
 <20140217020519.GC9879@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5AmsyyvoXsVoquu3mt3URbwJoqDi0gg93LJnaeMhJfGPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 16, 2014 at 11:05 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Thu, Feb 13, 2014 at 01:53:58PM -0200, Fabio Estevam wrote:
>> GPIO4_10 is the GPIO used to turn on the regulator that powers up the codec.
>>
>> Add a hog entry for it.
>
> I'm going to be strict on hog pin use.  It does not sound like a true
> hog pin.  Is it possible to have a pinctrl state for that regulator
> setting this pin up?

Could you please explain when a pin should or should not be placed
into the hog group?

Regards,

Fabio Estevam
