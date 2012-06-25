From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 25 Jun 2012 09:49:05 +0100
Subject: [PATCH 1/1 v2] ARM: only call smp_send_stop() on SMP
In-Reply-To: <20120625005134.GA2342@S2101-09.ap.freescale.net>
References: <1340533690-4049-1-git-send-email-javier@dowhile0.org>
 <20120625005134.GA2342@S2101-09.ap.freescale.net>
Message-ID: <20120625084905.GD19226@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2012 at 08:51:37AM +0800, Shawn Guo wrote:
> It seems the same patch has been there for a while.
> 
> http://thread.gmane.org/gmane.linux.kernel/1303115

Bah, why doesn't stuff like this get resent if nothing has happened for
a while?
