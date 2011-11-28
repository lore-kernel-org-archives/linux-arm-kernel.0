From: coelho@ti.com (Coelho, Luciano)
Date: Mon, 28 Nov 2011 09:50:18 +0200
Subject: [PATCH 3/3] omap: board-sdp4430: declare support for
 MMC_PM_KEEP_POWER
In-Reply-To: <1321970539-7104-3-git-send-email-eliad@wizery.com>
References: <1321970539-7104-1-git-send-email-eliad@wizery.com>
 <1321970539-7104-3-git-send-email-eliad@wizery.com>
Message-ID: <CAKd1q9pv5hMSpazYiZpmoowV52GvE7gFK5zUJSGpKhNkDZGuVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eliad,

On Tue, Nov 22, 2011 at 4:02 PM, Eliad Peller <eliad@wizery.com> wrote:
> Declare support for keeping the power of the wlan chip
> while suspended. this is needed for Wakeup-On-Wireless.
>
> Signed-off-by: Eliad Peller <eliad@wizery.com>
> ---
> ?arch/arm/mach-omap2/board-4430sdp.c | ? ?1 +
> ?1 files changed, 1 insertions(+), 0 deletions(-)

What about all the other board files that also have this structure?
For example board-omap4panda.c? I think they should all be changed and
the change should also be communicated more broadly for those board
files which (unfortunately) are not upstream (or which are upstream
but without the wl12xx-specific definitions on it, such as Beagle).


-- 
Cheers,
Luca.
