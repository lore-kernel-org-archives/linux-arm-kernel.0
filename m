From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 22 Aug 2013 07:21:47 -0700
Subject: [GIT PULL 1/5] ARM: imx: weim bus driver update for 3.12
In-Reply-To: <20130822141021.GH30533@S2101-09.ap.freescale.net>
References: <1376833688-24542-1-git-send-email-shawn.guo@linaro.org>
 <874nahx4o7.fsf@linaro.org>
 <20130822141021.GH30533@S2101-09.ap.freescale.net>
Message-ID: <CAGa+x84ogjo=zZW3f5GmPAA0wfxgRRqQKmkpPLetLMAx-YA4UA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 7:10 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Thu, Aug 22, 2013 at 05:59:04AM -0700, Kevin Hilman wrote:
>
> <snip>
>
>> >       drivers: bus: imx-weim: Add support for i.MX1/21/25/27/31/35/50/51/53
>> >
>> >  Documentation/devicetree/bindings/bus/imx-weim.txt |   17 ++-
>> >  drivers/bus/Kconfig                                |    3 +-
>> >  drivers/bus/imx-weim.c                             |  129 +++++++++++---------
>> >  3 files changed, 87 insertions(+), 62 deletions(-)
>>
>> The bindings changes in the last patch need a a review and ack from the
>> devicetree maintainers.
>>
>> Can you please repost that patch with devicetree at vger.kernel.org Cc'd?
>>
> Okay, will do.

Looking closer at this, seems this change is a trivial binding update
that just generalizes the binding to more SoCs.  I'm OK with taking
that change.  But in the future, please make sure binding changes are
posted to the DT list.

>> Without a review/ack from the DT maintainers, we won't be pulling any
>> bindings changes.
>>
>> Also, the binding is changed but there are no corresponding .dts file
>> changes.  Was that an oversight, or doess that mean there are no current
>> users of this binding.
>
> The binding changes does not break the existing users, and new users are
> added through imx/dt branch.

OK, thanks for the clarification.

Kevin
