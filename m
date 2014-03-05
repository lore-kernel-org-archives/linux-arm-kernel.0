From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 5 Mar 2014 16:07:46 +0100
Subject: [PATCH 3/4] clk: shmobile: add CPG driver for rz-platforms
In-Reply-To: <1460103.hdWs652aMT@avalon>
References: <1393621768-12568-1-git-send-email-wsa@the-dreams.de>
 <2207635.bd10VfTU6U@avalon> <20140305135431.GA7985@katana>
 <1460103.hdWs652aMT@avalon>
Message-ID: <20140305150746.GA9228@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> That's fine with me (although given the low complexity I would probably have 
> gone directly to supporting both clocks) as long as we can ensure both forward 

We need to wait for GPIO support anyhow to get it real.

> and backward compatibility. Should we give a name to the clock input through 
> the clock-names property for that reason ?

Not needed IMO.

> > Note that the devkit will most likely be the only board ever with a
> > selectable root clock.
> 
> Most probably, but that's no reason not to support it :-)

Not in itself. Yet a low demand might be, a demand of 0 surely is ;)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140305/d7ef843e/attachment-0001.sig>
