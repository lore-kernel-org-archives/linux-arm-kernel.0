From: khilman@ti.com (Kevin Hilman)
Date: Thu, 07 Jul 2011 10:05:10 -0700
Subject: [PATCH 0/3] Add generic idle notifiers
In-Reply-To: <1309229190-25006-1-git-send-email-toddpoynor@google.com> (Todd
	Poynor's message of "Mon, 27 Jun 2011 19:46:27 -0700")
References: <1309229190-25006-1-git-send-email-toddpoynor@google.com>
Message-ID: <87ei22dnsp.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Todd Poynor <toddpoynor@google.com> writes:

> Add notifiers for idle entry and exit, called with IDLE_START when a
> CPU goes idle and IDLE_END when it goes out of idle, based on the
> existing idle notifiers for the x86_64 arch.
>
> Convert x86_64 to use these notifiers, and call the notifiers on ARM.
>
> Convert the ARM LEDs events for idle start/end to these notifiers.

Is this intended to replace the more general CPU PM notifiers proposed
by Colin:

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/052827.html

Kevin
