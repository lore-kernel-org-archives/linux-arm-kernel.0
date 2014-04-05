From: w@1wt.eu (Willy Tarreau)
Date: Sat, 5 Apr 2014 21:03:27 +0200
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <0C4C0FAEF99D49748D4838E9B71A8489@fatboyfat.co.uk>
References: <20140326201243.GA1536@obsidianresearch.com>
 <CAAfodu0xZ0V8ikJMT1Z+0JSLeD+nezWAcGNF2_ryvad5tsVDWA@mail.gmail.com>
 <20140326214259.GA12330@obsidianresearch.com>
 <alpine.DEB.2.10.1403270025160.1545@vroombuntu>
 <20140327044054.GA22681@obsidianresearch.com>
 <alpine.DEB.2.10.1403280056250.4521@vroombuntu>
 <alpine.DEB.2.10.1404041408280.8617@vroombuntu>
 <20140405193435.50d8dd81@skate> <20140405180416.GB29787@1wt.eu>
 <0C4C0FAEF99D49748D4838E9B71A8489@fatboyfat.co.uk>
Message-ID: <20140405190327.GD29787@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 05, 2014 at 07:55:03PM +0100, Neil Greatorex wrote:
> Willy, Thomas,  
> 
> I have the igb module blacklisted so that it doesn???t get loaded during
> boot. Then I simply did:
> 
> # echo 1 > /sys/bus/pci/devices/0000\:01\:00.1/remove
> # modprobe igb  

Hehe feeling stupid now :-)
Thanks for the trick, that's really useful.

> and it only fires up the first port. I have tried the reverse (and removed
> 0000:01:00.0 instead) but that gives the oops.

Quite interesting indeed.

Thanks,
Willy
