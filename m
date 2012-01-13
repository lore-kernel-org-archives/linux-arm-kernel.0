From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 13 Jan 2012 14:48:29 +0100
Subject: [RFC PATCH v3 2/5] pinctrl: add dt binding support for pinmux
 mappings
In-Reply-To: <20120113133552.GB17029@S2101-09.ap.freescale.net>
References: <CAA+hA=RBqpSmntS2h+6xMQuRvSRHenmDgrYSSzMXHtOCpU+HCQ@mail.gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17761F18F8@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC605788507F698@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE39E6B@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC605788508AC65@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE3A76A@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC605788508E7B0@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF17801D1DD6@HQMAIL01.nvidia.com>
 <20120113035506.GB12184@S2101-09.ap.freescale.net>
 <7FE21149F4667147B645348EC605788508FD9C@039-SN2MPN1-013.039d.mgd.msft.net>
 <20120113133552.GB17029@S2101-09.ap.freescale.net>
Message-ID: <4F10362D.3020507@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13/2012 02:35 PM, Shawn Guo wrote:
> My guess is that Linus.W did not get any chance to take the dt case
> into account with his first design of pinctrl core.  But I guess he
> is open to any reasonable change to pinctrl core for dt adoption.
> Linus?

Any patches welcome.

However we cannot *require* DT for pinctrl to work, there
are archs that do not use DT and these must also be able
to use pinctrl. For example arch/blackfin have expressed
interest IIRC.

Then the question of whether to also support mixed configs
where some callers get data from DT and some from
platform data. I suspect that this is necessary for the
single kernel goal.

Yours,
Linus Walleij
