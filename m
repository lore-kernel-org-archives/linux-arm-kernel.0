From: rabin@rab.in (Rabin Vincent)
Date: Mon, 22 Feb 2010 23:46:57 +0530
Subject: [PATCH 00/10] ARM: ftrace: cleanups, Thumb-2, and dynamic ftrace
In-Reply-To: <1266090518-31120-1-git-send-email-rabin@rab.in>
References: <1266090518-31120-1-git-send-email-rabin@rab.in>
Message-ID: <20100222181657.GA4102@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steven / Frederic / Ingo,

On Sun, Feb 14, 2010 at 01:18:28AM +0530, Rabin Vincent wrote:
> This series contains fixes and improvements to the ARM ftrace support.  It adds
> Thumb-2 support and re-implements the dynamic ftrace support.
> 
> "ftrace: allow building without frame pointers" and "ftrace: pass KBUILD_CFLAGS
> to record_mcount.pl" are non-ARM-specific ftrace patches which are required to
> support the ARM functionality.

Ping.  Any comments on this?

Rabin
