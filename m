From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 21 Aug 2014 15:12:46 -0500
Subject: [PATCH] i2c: rk3x: fix bug that cause transfer fails in master
 receive mode
In-Reply-To: <5150326.5TB64kCfF4@typ>
References: <1408643457-7126-1-git-send-email-addy.ke@rock-chips.com>
 <53F634AF.1010303@cogentembedded.com>
 <20140821181738.GA1443@katana> <5150326.5TB64kCfF4@typ>
Message-ID: <20140821201246.GB1443@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Actually, reads with >32 bytes of data are possible with the controller. The 
> hw returns the data in 32 byte chunks. Our chunk handling code is just buggy. 

Understood. Then, I'd prefer 'chunk' in the commit message instead of
'transaction'.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140821/467dadf3/attachment.sig>
