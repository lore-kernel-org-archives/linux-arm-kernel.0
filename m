From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 5 Jan 2012 01:11:33 +0100
Subject: [PATCH 8/9] arm/tegra: seaboard: add EMC table to device tree
In-Reply-To: <CAOesGMhROzwyqMS89Nq0m6KRLNTbrkFrH9pUe6tfPR8gKTU+QA@mail.gmail.com>
References: <1324599468-12845-1-git-send-email-olof@lixom.net>
 <1324599468-12845-9-git-send-email-olof@lixom.net>
 <74CDBE0F657A3D45AFBB94109FB122FF17761F1590@HQMAIL01.nvidia.com>
 <CAOesGMhROzwyqMS89Nq0m6KRLNTbrkFrH9pUe6tfPR8gKTU+QA@mail.gmail.com>
Message-ID: <CACRpkdbtY+vOc-X8Ay1RyN61Xseepc2X-NnvFe=G++ASwrpOxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 5, 2012 at 12:55 AM, Olof Johansson <olof@lixom.net> wrote:
> On Wed, Jan 4, 2012 at 3:51 PM, Stephen Warren <swarren@nvidia.com> wrote:
>> Olof Johansson wrote at Thursday, December 22, 2011 5:18 PM:
>>> Timings for the T25 version of seaboard, only one memory manufacturer
>>> and timing table (two speeds).
>>
>> There exist Seaboards with Tegra20 rather than Tegra25. Should we:
>> * Rename tegra-seaboard.dts to tegra-seaboard.dtsi
>> * Create tegra-seaboard-t20.dts and tegra-seaboard-t25.dts which include
>> ?tegra-seaboard.dtsi, and add the EMC tables to the Tegra25 version only?
>
> Honestly, T20 seaboards are deprecated around here, we've been
> replacing all we have with T25 models and keeping T20 support around
> is a pain. I'd rather just ignore them if we can.

It's fun how board prototype problems sping up in several similar
companies :-)

When I am confronted with similar problems I have taken the stance:

Q: is the board available outside my company esp to community
 people and other hackers who will be pissed if I screw it up?

If the answer is no, and there is no risk that anyone will blame you
for it on this mailinglist - delete it. Then handle the people that
yell at you internally and ask them to bring their board to the
junkpile.

Yours,
Linus Walleij
