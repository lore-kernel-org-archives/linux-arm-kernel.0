From: eliad@wizery.com (Eliad Peller)
Date: Mon, 28 Nov 2011 10:26:42 +0200
Subject: [PATCH 3/3] omap: board-sdp4430: declare support for
 MMC_PM_KEEP_POWER
In-Reply-To: <CAKd1q9pv5hMSpazYiZpmoowV52GvE7gFK5zUJSGpKhNkDZGuVg@mail.gmail.com>
References: <1321970539-7104-1-git-send-email-eliad@wizery.com>
 <1321970539-7104-3-git-send-email-eliad@wizery.com>
 <CAKd1q9pv5hMSpazYiZpmoowV52GvE7gFK5zUJSGpKhNkDZGuVg@mail.gmail.com>
Message-ID: <CAB3XZEenx7L07BYmrHGt0h9ZAY-LOpWXL+in0vs7XOoeBf_LUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2011 at 9:50 AM, Coelho, Luciano <coelho@ti.com> wrote:
> On Tue, Nov 22, 2011 at 4:02 PM, Eliad Peller <eliad@wizery.com> wrote:
>> Declare support for keeping the power of the wlan chip
>> while suspended. this is needed for Wakeup-On-Wireless.
>>
>> Signed-off-by: Eliad Peller <eliad@wizery.com>
>> ---
>> ?arch/arm/mach-omap2/board-4430sdp.c | ? ?1 +
>> ?1 files changed, 1 insertions(+), 0 deletions(-)
>
> What about all the other board files that also have this structure?
> For example board-omap4panda.c? I think they should all be changed and
> the change should also be communicated more broadly for those board
> files which (unfortunately) are not upstream (or which are upstream
> but without the wl12xx-specific definitions on it, such as Beagle).
>
i preferred adding this capability only for boards i can test.
unfortunately, i don't a panda/beagle setup.
anyway, i don't think we have to add it all at once.
let's just do it one board at a time... i'll add support for zoom as
well. any volunteers for panda/beagle? ;)

Eliad.
