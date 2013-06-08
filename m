From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 8 Jun 2013 08:59:50 +0100
Subject: [PATCH 2/5] arm: preserve ATAGS in /chosen/atags in the Device
 Tree
In-Reply-To: <20130607112101.2cedbc5f@skate>
References: <1370414409-29991-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1370414409-29991-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130606142851.6dd17cad@skate>
 <alpine.LFD.2.03.1306061253430.18597@syhkavp.arg>
 <20130607112101.2cedbc5f@skate>
Message-ID: <20130608075950.GG18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 11:21:01AM +0200, Thomas Petazzoni wrote:
> Well, I don't think what you say here is really fair. Before the DT was
> in place, unless I missed it, there was no standard way of letting the
> bootloader pass MAC addresses to the kernel.

Before DT was in place, passing MAC addresses via ATAGs had been
proposed several times.  This had been rejected each time.  Hooks
into the networking code had been proposed several times in various
forms, including via a command line option, and each time it had
been rejected by the networking folk.
