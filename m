From: w@1wt.eu (Willy Tarreau)
Date: Tue, 8 Apr 2014 19:56:54 +0200
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <CAFJTrDtiRctixnbBEbHMsnxsPy7ew9-7SoD5cyUA6DWPU9p6Fw@mail.gmail.com>
References: <alpine.DEB.2.10.1404041408280.8617@vroombuntu>
 <20140406185833.GI29787@1wt.eu>
 <alpine.DEB.2.10.1404062253500.16719@vroombuntu>
 <20140407174106.GD9952@obsidianresearch.com>
 <CAAfodu0kbTspq2QQf0dh3U7LB-q+ECaX9FJ35fCc25UmgPJZSg@mail.gmail.com>
 <20140407204817.GB20736@obsidianresearch.com>
 <alpine.DEB.2.10.1404072239050.32332@vroombuntu>
 <20140408064003.GU29787@1wt.eu>
 <CAFJTrDu82avr6mSaz1PNzOJ0tnQiH5aiq6URiXZAbJ=4W+2EJg@mail.gmail.com>
 <CAFJTrDtiRctixnbBEbHMsnxsPy7ew9-7SoD5cyUA6DWPU9p6Fw@mail.gmail.com>
Message-ID: <20140408175654.GI11052@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 08, 2014 at 01:31:48PM +0100, Matthew Minter wrote:
> To add to my previous point, I would consider releasing these patches
> as soon as possible as it seems that it can easily cause panics on a
> range of boards.

On the other hand, it's not the random user who stuffs PCIe cards on
such boards PCIe slots, so in general there's a long testing period.
We identified the igb issue in mid-december without getting completely
down on it, so we remained 3 months without any other single report
about this. Thus I think that the only persons really interested in
having these patches are in this thread, so the emergency is not that
high :-)

Cheers,
Willy
