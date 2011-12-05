From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 5 Dec 2011 16:39:35 +0530
Subject: [PATCH v5 1/4] regulator: helper routine to extract
 regulator_init_data
In-Reply-To: <20111205105733.GE11150@opensource.wolfsonmicro.com>
References: <1321615040-13257-1-git-send-email-rnayak@ti.com>
 <1321615040-13257-2-git-send-email-rnayak@ti.com>
 <CAJuYYwRO+AS=WmQfNAe8L6Gi5Dm4VsCuVqk3X5Nb8uUYAdLnJQ@mail.gmail.com>
 <20111204155433.GA16287@opensource.wolfsonmicro.com>
 <CAJuYYwQ-9wCu-+q0S2YYeFYemq74ULdZ-EwPGLWKHA4+0VZcsA@mail.gmail.com>
 <20111205103447.GC11150@opensource.wolfsonmicro.com>
 <CAJuYYwSRW-=XufvHS1miO2xNANwQMZqPbt=VyPEonywnAsvVUQ@mail.gmail.com>
 <20111205105733.GE11150@opensource.wolfsonmicro.com>
Message-ID: <CAJuYYwTu6iPBSy63Y65KtO1iR7PLKQkmFZn6uS4yv_o8ZWSftw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 December 2011 16:27, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Dec 05, 2011 at 04:14:40PM +0530, Thomas Abraham wrote:
>> On 5 December 2011 16:04, Mark Brown
>
>> > With the regulator device tree bindings if the regulator is configured
>> > to run a single voltage the bindings will set apply_uV unconditionally
>> > so there's no need for a separate constraint.
>
>> Sorry if I have missed this, but I could not find 'apply_uV' being set
>> as you described in the v5 of the regulator-dt patchset.
>
> Yes, looks like Rajendra missed that - just fixed it.
>

Thanks Mark. Could you please push your change.

Regards,
Thomas.
