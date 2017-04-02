From: andi@firstfloor.org (Andi Kleen)
Date: Sun, 02 Apr 2017 13:47:42 -0700
Subject: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for
 embedded systems
In-Reply-To: <20170401222119.25106-1-nicolas.pitre@linaro.org> (Nicolas
 Pitre's message of "Sat, 1 Apr 2017 18:21:14 -0400")
References: <20170401222119.25106-1-nicolas.pitre@linaro.org>
Message-ID: <87pogur0y9.fsf@firstfloor.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre <nicolas.pitre@linaro.org> writes:
>
> Of course, making it "mini" means there are limitations to what it does:
>
> - This supports serial ports only. No VT's, no PTY's.

No PTYs seems like a big limitation. This means no sshd?

> But again, most small embedded systems simply don't need those things.

They don't need a (debug) way to login over the network? Hard to
believe.

Most of the other stuff we could indeed do without even on larger
systems.

-Andi
