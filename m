From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 10 Apr 2015 23:35:23 +0200
Subject: [PATCH v2 0/4] arm: tegra: implement NVEC driver using tegrai2c.
In-Reply-To: <1549160.njMIY2NVTi@fb07-iapwap2>
References: <1427745615-5428-1-git-send-email-danindrey@mail.ru>
 <20150403194635.GC2016@katana> <1549160.njMIY2NVTi@fb07-iapwap2>
Message-ID: <20150410213523.GA15596@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> One thing where we need your help as a I2C maintainer is how to represent an 
> i2c slave device using device-tree. You may remember our discussion in the 
> past from here [1] where you suggested to just make a slave client by its 
> compatible name. Stephen Warren from NVIDIA raised some concerns about this 
> solution because it may not be appropriate in all possible future cases (which 
> is what a proper device-tree representation should take care off). He instead 
> suggested to mark a slave client by adding some flag to the reg property, to 
> be able to handle a situation where both master client and slave client have 
> the same i2c bus address forming a loopback (e.g. for testing purpose) on the 
> same bus. More details here [2].
> 
> I hope with this post I can join the different discussions somehow so we are 
> able to find a common sense which is acceptable for all.

I'll have a look again for 4.2.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150410/577d2d97/attachment.sig>
