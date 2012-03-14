From: arjan@linux.intel.com (Arjan van de Ven)
Date: Tue, 13 Mar 2012 19:04:49 -0700
Subject: [PATCH 0/3] coupled cpuidle state support
In-Reply-To: <8762e8kqi6.fsf@ti.com>
References: <1324426147-16735-1-git-send-email-ccross@android.com>
 <4F1929E9.7070707@linaro.org> <8762e8kqi6.fsf@ti.com>
Message-ID: <4F5FFCC1.2030702@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/13/2012 4:52 PM, Kevin Hilman wrote:
> Checking the ready_count seemed like an easy way to do this, but did you
> have any other mechanisms in mind for CPUs to communicate that they've
> exited/aborted?

this indeed is the tricky part (which I warned about earlier);
I've spent quite a lot of time (weeks) to get this provably working for
an Intel system with similar requirements... and it's extremely unfunny,
and needed firmware support to close some of the race conditions.

I sure hope that hardware with these requirements is on the way out...
it's not very OS friendly.
