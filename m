From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Jan 2018 22:53:14 +0100
Subject: [PATCH 1/3] arm: spear600: Add missing interrupt-parent of rtc
In-Reply-To: <CAOesGMiyfpRyoe4dxQeNMF5invysVBEy+J5OwUhuop=JyAvZoQ@mail.gmail.com>
References: <a062d9ed0d3365b578156a780202fa533e725374.1515650104.git.viresh.kumar@linaro.org>
 <20180112020711.6gp2pnsxxjzelidq@localhost> <20180112032223.GK3626@vireshk-i7>
 <CAOesGMggU73asY1SEUDD_BsWcrGYR___o8e5omjziOPEwJgqBQ@mail.gmail.com>
 <CAK8P3a2SO4=YKBE3L_AKsyfNe77YR7a8F=dvbS=ic03=6NK8MA@mail.gmail.com>
 <CAOesGMgcf9FovbzhPkKnrG4ETRFP3dsSJnTYNfp1wECMFeFOGA@mail.gmail.com>
 <CAL_JsqJVWLazDRB1me2OubqqMhdsqsR+cLSHR+K0OY3dZHcE-w@mail.gmail.com>
 <CAOesGMiyfpRyoe4dxQeNMF5invysVBEy+J5OwUhuop=JyAvZoQ@mail.gmail.com>
Message-ID: <CAK8P3a3KTz0sOSbO9+sAY1Sv95hZF4Yg1qMzOaXPAZ_1pOgGpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 12, 2018 at 10:50 PM, Olof Johansson <olof@lixom.net> wrote:
> On Fri, Jan 12, 2018 at 12:45 PM, Rob Herring <robh+dt@kernel.org> wrote:
>> On Fri, Jan 12, 2018 at 12:23 PM, Olof Johansson <olof@lixom.net> wrote:
>> I have more dtc checks in the works (nothing for 4.16 :) ). I'd like
>> the process to work better. I'm not going to fix all the warnings. I
>> don't think Arnd should either. Turning them off by default hasn't
>> worked great either. For some, I'm not sure we can ever get to warning
>> free, but I'd like new stuff to have warnings enabled and no one
>> builds with W=1. We could put together tooling to just show new
>> warnings, but someone has to run it and enforce it. I could stick dtc
>> updates into linux-next for multiple cycles before sending to Linus.
>
> I'll split up and report DT warnings separate from compiler, seems
> like a reasonable approach.

Maybe also report any other output from the build process as another
category. When things build fine, we should see no output at all.

        Arnd
