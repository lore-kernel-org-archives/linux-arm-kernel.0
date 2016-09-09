From: jagan@amarulasolutions.com (Jagan Teki)
Date: Sat, 10 Sep 2016 03:51:42 +0530
Subject: [PATCH v3 2/3] ARM: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual
 initial support
In-Reply-To: <CAOMZO5D2WNBh6fy8iFYasSZnovfBJRxzBt55ceaPqwCn3zvepg@mail.gmail.com>
References: <1473457525-27768-1-git-send-email-jagan@amarulasolutions.com>
 <1473457525-27768-2-git-send-email-jagan@amarulasolutions.com>
 <CAOMZO5BPhY14S4G541MTpsCW64SsCiNcsksJarBCWqGOnaPf3A@mail.gmail.com>
 <CAMty3ZC+49D7aALOKcsjoiqptQwrrtHGMAGCtcPn51QDsksSSQ@mail.gmail.com>
 <CAMty3ZAM-sZ0aZU0Z+8WhDcepx8KM96xUbn+n3UcDSjFTafC-A@mail.gmail.com>
 <CAOMZO5AuZ5DqqKngLw67_-3PdoYx5pMNmm1ZHwRd79rYPJY-+Q@mail.gmail.com>
 <CAOMZO5D2WNBh6fy8iFYasSZnovfBJRxzBt55ceaPqwCn3zvepg@mail.gmail.com>
Message-ID: <CAMty3ZAPbJM5EQD_OqN9nr---y1P0e+5Y5ujL4g7YoPEsuU+aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 10, 2016 at 3:49 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Fri, Sep 9, 2016 at 7:19 PM, Fabio Estevam <festevam@gmail.com> wrote:
>> On Fri, Sep 9, 2016 at 7:14 PM, Jagan Teki <jagan@amarulasolutions.com> wrote:
>>
>>>> Yeah, I got 1b0b0
>>>>
>>>> U-Boot > md.l 20E05DC 1
>>>> 020e05dc: 0001b0b0
>>>
>>> So I'm assigning change value to 1b020 Linux that's ok right?
>>
>> Then just use 0x1b020 for the flexcan pins.
>
> 1b0b0 I mean :-)

Why? can't we update iomux reg value any side effects or something.

thanks!
-- 
Jagan Teki
Free Software Engineer | Amarula Solutions
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.
