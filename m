From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 17 Jul 2017 10:47:38 -0700
Subject: [PATCH v3] ARM: dts: da850-evm: drop VPIF endpoints
In-Reply-To: <55429c4a-987d-a157-9565-eef04daeefea@ti.com> (Sekhar Nori's
 message of "Mon, 17 Jul 2017 16:30:33 +0530")
References: <20170615215730.28585-1-khilman@baylibre.com>
 <55429c4a-987d-a157-9565-eef04daeefea@ti.com>
Message-ID: <7hzic3t0p1.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sekhar Nori <nsekhar@ti.com> writes:

> Hi Kevin,
>
> On Friday 16 June 2017 03:27 AM, Kevin Hilman wrote:
>> Drop the unused endpoints.  They should only be used when there is
>> an actual remote-endpoint connected.
>> 
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>
> A similar patch is needed for da850-lcdk too. In fact with v4.13-rc1, 
> without it, we get a warning splat that starts with:
>
> WARNING: CPU: 0 PID: 129 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x5c/0x7c
> sysfs: cannot create duplicate filename '/bus/platform/devices/vpif_capture'
>
> I am adding this patch to fixes and would like to send this along with 
> a similar LCDK patch (hopefully both for -rc2). While committing this I 
> will add "unused" to subject line too.

Patch for LCDK sent, with "unused" added to the subject line.

Kevin
