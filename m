From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 12 Sep 2014 14:15:10 +0200
Subject: [RFC 4/4] ARM: shmobile: r8a7790: adapt DTS for I2C slave support
In-Reply-To: <1921859.32moD2F04k@fb07-iapwap2>
References: <1410274470-12712-1-git-send-email-wsa@the-dreams.de>
 <7627175.tG5quZH0VN@fb07-iapwap2> <20140912095821.GB1930@katana>
 <1921859.32moD2F04k@fb07-iapwap2>
Message-ID: <20140912121510.GD1930@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Am I missing something? Board properties can be encoded within the
> > compatible entries ("ax100-ec", "ax200-ec"...). I'd think this means
> > mostly different protocols, though.
> 
> well, ac100 is the name of the board and nvec is the name of the protocol. 

Yes, the driver could be named nvec, yet the compatible-strings should
be similar to above. From that, the driver can deduce the protocol
variant and possible initial settings.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140912/28755602/attachment-0001.sig>
