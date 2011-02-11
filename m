From: ccross@android.com (Colin Cross)
Date: Thu, 10 Feb 2011 17:44:31 -0800
Subject: [PATCH v4 10/15] ARM: tegra: iomap: Add missing devices, fix use
	of SZ_8, SZ_64
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0310F60414@HQMAIL01.nvidia.com>
References: <1297320204-31882-1-git-send-email-ccross@android.com>
	<1297320204-31882-11-git-send-email-ccross@android.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310F60414@HQMAIL01.nvidia.com>
Message-ID: <AANLkTi=ZrTsvLoocLeztqzGK4TUgt1pFnHR-0MBUmOc0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 10, 2011 at 8:45 AM, Stephen Warren <swarren@nvidia.com> wrote:
> Colin Cross wrote at Wednesday, February 09, 2011 11:43 PM:
>>
>> From: Gary King <gking@nvidia.com>
>>
>> Adds gart, hdmi, avp, host1x, and pwm controllers to mach/iomap.h
>> There is no SZ_8 or SZ_64, replace them with constants
>
> Can't we add those SZ_* constants?

Sure, you already added SZ_64, and nothing depends on the SZ_8 defines
right now, so I'll drop that part of the change and send a patch that
completes the SZ_* defines.
