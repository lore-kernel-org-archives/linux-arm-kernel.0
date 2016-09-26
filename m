From: peter.senna@collabora.co.uk (Peter Senna Tschudin)
Date: Mon, 26 Sep 2016 09:58:26 +0100
Subject: =?utf-8?q?Re=3A?==?utf-8?q?_=5BPATCH?= V5 =?utf-8?q?3=2F4=5D?=
 =?utf-8?q?_drm=2Fbridge=3A?= Add driver for GE B850v3
 =?utf-8?q?LVDS=2FDP++?= Bridge
In-Reply-To: <c157d4a6-2d63-07d6-4274-883d79c8ab9e@codeaurora.org>
Message-ID: <3a56-57e8e300-3-10c8a340@87357206>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hi Archit,

On Monday, September 26, 2016 10:31 CEST, Archit Taneja <architt@codeaurora.org> wrote: 
 
> Hi Peter,
> 
> On 09/26/2016 01:57 PM, Peter Senna Tschudin wrote:
> > Patch 1/4 is already on linux-next, but what about this one? Ping?

> 
> I'd posted some queries a couple of times which you didn't answer to.
> Could you please respond to them before we try to get this merged?

Your queries were already answered by similar questions. The commit messages and cover letter also addresses the design decisions of the code. But basically the driver usefulness to other scenarios is severely limited by the firmware used by both chips. And when using the firmware that goes with this specific hardware, then yes, the two chips are always expected to work together. But the main point is that with the custom firmware each chip do not behave as independent bridges anymore.

On the other side, I was careful to use meaningful names for the registers, so a future implementation based on same chips can take the basics from this work, at least as a starting point.

Thanks,

Peter
