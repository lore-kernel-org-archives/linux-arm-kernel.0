From: ccross@android.com (Colin Cross)
Date: Sun, 5 Dec 2010 15:52:18 -0800
Subject: [PATCH 02/21] ARM: gic: Add functions to save and restore gic
	state
In-Reply-To: <20101205233021.GA22824@n2100.arm.linux.org.uk>
References: <1291590548-7341-1-git-send-email-ccross@android.com>
	<1291590548-7341-3-git-send-email-ccross@android.com>
	<20101205233021.GA22824@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikY2R8KfdR2EU9TNhPi57PPfQ4ibXnzb=_hp9Fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 5, 2010 at 3:30 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Dec 05, 2010 at 03:08:49PM -0800, Colin Cross wrote:
>> on systems with idle states which power-gate the logic including
>> the gic, such as tegra, the gic distributor needs to be shut down
>> and restored on entry and exit from the architecture idle code
>
> This clashes with the GIC cleanups I've previously posted.

Yes, I mentioned that in the patch set overview.  I wanted to get the
concept out there for review, I'll fix it up and repost it once your
patches are final before submitting anything to the patch system.
