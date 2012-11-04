From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 4 Nov 2012 10:13:27 +0000
Subject: [PATCH 8/9] ARM: support uprobe handling
In-Reply-To: <1350242593-17761-8-git-send-email-rabin@rab.in>
References: <1350242593-17761-1-git-send-email-rabin@rab.in>
 <1350242593-17761-8-git-send-email-rabin@rab.in>
Message-ID: <20121104101327.GZ21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 14, 2012 at 09:23:12PM +0200, Rabin Vincent wrote:
> Extend the kprobes code to handle user-space probes.  Much of the code
> can be reused so currently the ARM uprobes code reuses the kprobes
> structures.  The decode tables are reused, with the modification that
> for those instruction that require custom decoding for uprobes, a new
> element is added in the table to specify a custom decoder function.

How are accesses to userspace handled by the kprobes code?  Please point
me to where these accesses are performed.
