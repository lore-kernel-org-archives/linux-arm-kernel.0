From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 28 Jun 2011 14:25:16 -0400 (EDT)
Subject: [PATCH 0/3] Add generic idle notifiers
In-Reply-To: <1309229190-25006-1-git-send-email-toddpoynor@google.com>
References: <1309229190-25006-1-git-send-email-toddpoynor@google.com>
Message-ID: <alpine.LFD.2.00.1106281422560.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 27 Jun 2011, Todd Poynor wrote:

> Add notifiers for idle entry and exit, called with IDLE_START when a
> CPU goes idle and IDLE_END when it goes out of idle, based on the
> existing idle notifiers for the x86_64 arch.
> 
> Convert x86_64 to use these notifiers, and call the notifiers on ARM.
> 
> Convert the ARM LEDs events for idle start/end to these notifiers.

This is nice.

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

for all 3 patches.


Nicolas
