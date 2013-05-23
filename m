From: w@1wt.eu (Willy Tarreau)
Date: Thu, 23 May 2013 08:52:59 +0200
Subject: [PATCH 0/4] Marvell PCIe driver improvements
In-Reply-To: <20130523083509.79297513@skate>
References: <1369228358-32580-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130523001353.GH31625@1wt.eu> <20130523083509.79297513@skate>
Message-ID: <20130523065259.GK31625@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 08:35:09AM +0200, Thomas Petazzoni wrote:
> > FWIW, these patches applied on top of your pcie-v10 tree have made
> > my mini-pcie dual-nic appear for the first time on the mirabox. Till
> > now I never knew if it was a hardware or software issue since the NIC
> > does not appear in u-boot nor lspci, whatever the kernel versions,
> > including the original Marvell one's. The NIC has two functions (one
> > per controller) and no bridge, so it may be a side effect of your
> > improvements (or maybe you fixed a bug).
> 
> Hum, interesting. Can you show the output of lspci -v and lspci -t
> (which a pciutils version of lspci, not Busybox one) ? I'm interested
> in seeing the layout of the PCIe bus with such a device, to get a
> better understanding.

(send privately in another thread).

> > Anyway for me it's a great improvement !
> > 
> > I've not tried it on the OpenBlocks AX3 yet (it was not detected
> > there previously). But I have good hopes.
> > 
> > For reference, the NIC is Jetway's ADMPEIDLA (intel i350-AM2).
> 
> Should I be taking this as a formal Tested-by from you? :-)

Yes, obviously, feel free to add this one :

  Tested-by: Willy Tarreau <w@1wt.eu>

Willy
