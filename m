From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Sat, 29 Nov 2014 00:26:30 +0200
Subject: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
In-Reply-To: <201411282241.12095@pali>
References: <20141027200008.GR2560@atomide.com> <201411271232.47231@pali>
 <20141128202719.GU2817@atomide.com> <201411282241.12095@pali>
Message-ID: <20141128222630.GA1382@fuloong-minipc.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Nov 28, 2014 at 10:41:12PM +0100, Pali Roh?r wrote:
> Does kernel provide some interface for telling userspace
> applications something like bootreason (e.g power key, software
> reset, rtc alarm, charger connected, ...)?

In N950/N9, NOLO passes this information using kernel command line
and applications are reading /proc/cmdline. If I remember correctly all
those custom proc files were removed from Nokia kernel, and everything
was passed via command line.

A.
