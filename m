From: lethal@linux-sh.org (Paul Mundt)
Date: Tue, 9 Nov 2010 08:54:07 +0900
Subject: [PATCH 6/6 v4] ARM: Add support for the display controllers in
	VT8500 and WM8505
In-Reply-To: <20101108234239.GA20819@alchark-u3s.lan>
References: <1289147348-31969-1-git-send-email-alchark@gmail.com>
	<1289147348-31969-6-git-send-email-alchark@gmail.com>
	<20101108041721.GA11605@linux-sh.org>
	<20101108141407.GA25739@alchark-u3s.lan>
	<20101108204315.GA12050@linux-sh.org>
	<AANLkTikXffMT9ZiUpm2QAoW+KPJN3MBf55Dgruj1EJN0@mail.gmail.com>
	<20101108213008.GB17708@linux-sh.org>
	<20101108234239.GA20819@alchark-u3s.lan>
Message-ID: <20101108235407.GB18385@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 09, 2010 at 02:42:39AM +0300, Alexey Charkov wrote:
> From 95942cc0cd0909d700c236ba63d3488ec9fccf1a Mon Sep 17 00:00:00 2001
> From: Alexey Charkov <alchark@gmail.com>
> Date: Tue, 9 Nov 2010 02:25:40 +0300
> Subject: [PATCH 3/3] ARM: Add support for the display controllers in VT8500 and WM8505
> 
> This adds drivers for the LCD controller found in VIA VT8500 SoC,
> GOVR display controller found in WonderMedia WM8505 SoC and for the
> Graphics Engine present in both of them that provides hardware
> accelerated raster operations (used for copyarea and fillrect).
> 
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
> 
> This incorporates fixes to the issues last mentioned by Paul.
> 
> I just dropped <asm/irq.h>, as that seems to be not used at all currently
> (must have been some old cut-and-paste as well). As for the Graphics
> Engine, I decided not to disable it for now at device exit time, at least
> until we reach a conclusion on how or whether to implement support for its
> alpha-mixing capabilities. Unlike with display drivers, this should have no
> user-visible consequences. This can be changed later, when time comes for
> device clocks and power management support.
> 
Looks good to me!

Reviewed-by: Paul Mundt <lethal@linux-sh.org>
