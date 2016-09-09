From: jagan@amarulasolutions.com (Jagan Teki)
Date: Sat, 10 Sep 2016 04:00:32 +0530
Subject: [PATCH v3 2/3] ARM: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual
 initial support
In-Reply-To: <CAOMZO5CpdL62frpVkHOQ4gGoXrVQv3AjiXqHoXfZW8RKTuxJXw@mail.gmail.com>
References: <1473457525-27768-1-git-send-email-jagan@amarulasolutions.com>
 <1473457525-27768-2-git-send-email-jagan@amarulasolutions.com>
 <CAOMZO5BPhY14S4G541MTpsCW64SsCiNcsksJarBCWqGOnaPf3A@mail.gmail.com>
 <CAMty3ZC+49D7aALOKcsjoiqptQwrrtHGMAGCtcPn51QDsksSSQ@mail.gmail.com>
 <CAMty3ZAM-sZ0aZU0Z+8WhDcepx8KM96xUbn+n3UcDSjFTafC-A@mail.gmail.com>
 <CAOMZO5AuZ5DqqKngLw67_-3PdoYx5pMNmm1ZHwRd79rYPJY-+Q@mail.gmail.com>
 <CAOMZO5D2WNBh6fy8iFYasSZnovfBJRxzBt55ceaPqwCn3zvepg@mail.gmail.com>
 <CAMty3ZAPbJM5EQD_OqN9nr---y1P0e+5Y5ujL4g7YoPEsuU+aw@mail.gmail.com>
 <CAOMZO5CpdL62frpVkHOQ4gGoXrVQv3AjiXqHoXfZW8RKTuxJXw@mail.gmail.com>
Message-ID: <CAMty3ZCP97SQ_J6xYN-qdmRK0hgbTsxmO5j+pJh8MX7xjAyjdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 10, 2016 at 3:55 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Fri, Sep 9, 2016 at 7:21 PM, Jagan Teki <jagan@amarulasolutions.com> wrote:
>
>> Why? can't we update iomux reg value any side effects or something.
>
> Sure you can change it.
>
> You were using 0x8000000 before and I assume you tested flexcan and it
> worked well.
>
> Putting 1b0b0 will keep the same setting, so no functional change.
>
> Why did you select 0x1b020?

We are not using can on bootloader either and we always update the
value in Linux which is 0x1b020 like for other imx6ul soc's as well.

-- 
Jagan Teki
Free Software Engineer | Amarula Solutions
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.
