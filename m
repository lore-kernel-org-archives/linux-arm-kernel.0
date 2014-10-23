From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu, 23 Oct 2014 12:16:52 +0200
Subject: [PATCH V2] tty: serial: omap: Increase max consoles and add check
 to prevent crash
In-Reply-To: <1413982010-11599-1-git-send-email-nm@ti.com>
References: <1413908616-843-1-git-send-email-nm@ti.com>
 <1413982010-11599-1-git-send-email-nm@ti.com>
Message-ID: <5448D594.4090300@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2014 02:46 PM, Nishanth Menon wrote:
> Increase the maximum number of consoles possible to 10 since DRA7 now
> has the maximum number of consoles possible. without doing this, for
> example, enabling DRA7 UART10 results in internal data structures and
> console cannot match up and we endup with a crash as follows:

good, Thanks.
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
