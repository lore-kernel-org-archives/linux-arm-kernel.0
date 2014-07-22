From: airlied@gmail.com (Dave Airlie)
Date: Tue, 22 Jul 2014 20:15:29 +1000
Subject: [PATCH] drm: shmobile: fix warnings
In-Reply-To: <20140722085225.GI21766@n2100.arm.linux.org.uk>
References: <E1X6Ho7-0006ru-U9@rmk-PC.arm.linux.org.uk>
 <20140722085225.GI21766@n2100.arm.linux.org.uk>
Message-ID: <CAPM=9ty6F8_i3G13MXQzO4-sEVSDfB=6pUPTDvfO8yyMpQ1T4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 July 2014 18:52, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Sun, Jul 13, 2014 at 12:19:03PM +0100, Russell King wrote:
>> drivers/gpu/drm/shmobile/shmob_drm_drv.c:300:5: warning: "CONFIG_PM_SLEEP" is not defined [-Wundef]
>>
>> Always use #ifdef with CONFIG symbols, never just bare #if
>>
>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>
> Ping?
>

I merged all these to -next earlier today,

I'm still looking at the other ones that have dependant patches on
Greg on how best to merge.

Dave.
