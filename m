From: horms@verge.net.au (Simon Horman)
Date: Thu, 22 Jan 2015 12:39:07 +0900
Subject: [PATCH 0/9] ARM: shmobile: r8a73a4/ape6evm multiplatform
In-Reply-To: <20150121015927.GB30598@verge.net.au>
References: <1421758306-24838-1-git-send-email-geert+renesas@glider.be>
 <20150121015927.GB30598@verge.net.au>
Message-ID: <20150122033907.GO31170@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 21, 2015 at 10:59:27AM +0900, Simon Horman wrote:
> On Tue, Jan 20, 2015 at 01:51:37PM +0100, Geert Uytterhoeven wrote:
> > 	Hi Simon, Magnus,
> > 
> > This patch series transitions the r8a73a4/ape6evm platform to support
> > multiplatform only:
> >   - Add CCF information to DT,
> >   - Disable legacy clock if CCF is used,
> >   - Add Bus State Controller node, and move the Ethernet node to it,
> >   - Remove ape6evm-reference,
> >   - Remove ape6evm-legacy and legacy support code.
> > 
> > This series is based on renesas-drivers-2015-01-19-v3.19-rc5.
> > It depends on renesas-devel-20150119-v3.19-rc5 (code-wise) and
> > clk-shmobile-for-3.20 (functionality-wise), for which I've sent a pull
> > request to Mike Turquette yesterday.
> > 
> > All of this was untested by me due to lack of hardware.
> > As Mike had previously acked the r8a73a4 CCF implementation, it's safe
> > to apply after testing.
> 
> Hi Geert, Hi Ulrich,
> 
> thanks for all your good work in getting this together.
> I have tested this and queued it up for v3.21.
> 
> I plan to push it to my devel branch later today.
> I plan to push it to my next branch and thus linux-next once
> clk-shmobile-for-3.20 appears in a v3.20-rc.

For the record: Olof has asked for review comments for the BSC driver and
binding patches. Accordingly I have dropped them, and these patches which
depend on them, from next.
