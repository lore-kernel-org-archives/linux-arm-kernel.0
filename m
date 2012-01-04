From: olof@lixom.net (Olof Johansson)
Date: Wed, 4 Jan 2012 15:55:15 -0800
Subject: [PATCH 8/9] arm/tegra: seaboard: add EMC table to device tree
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17761F1590@HQMAIL01.nvidia.com>
References: <1324599468-12845-1-git-send-email-olof@lixom.net>
 <1324599468-12845-9-git-send-email-olof@lixom.net>
 <74CDBE0F657A3D45AFBB94109FB122FF17761F1590@HQMAIL01.nvidia.com>
Message-ID: <CAOesGMhROzwyqMS89Nq0m6KRLNTbrkFrH9pUe6tfPR8gKTU+QA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 4, 2012 at 3:51 PM, Stephen Warren <swarren@nvidia.com> wrote:
> Olof Johansson wrote at Thursday, December 22, 2011 5:18 PM:
>> Timings for the T25 version of seaboard, only one memory manufacturer
>> and timing table (two speeds).
>
> There exist Seaboards with Tegra20 rather than Tegra25. Should we:
> * Rename tegra-seaboard.dts to tegra-seaboard.dtsi
> * Create tegra-seaboard-t20.dts and tegra-seaboard-t25.dts which include
> ?tegra-seaboard.dtsi, and add the EMC tables to the Tegra25 version only?

Honestly, T20 seaboards are deprecated around here, we've been
replacing all we have with T25 models and keeping T20 support around
is a pain. I'd rather just ignore them if we can.

> Are the timings for true Seaboard and the Springbank variant identical?

I don't know, Springbank is a mostly nvidia-internal spin that I
haven't used much. I was of that impression though, since we have
never picked up any new specific support for it, it just runs with
seaboard code.


-Olof
