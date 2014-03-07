From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 7 Mar 2014 15:26:14 +0100
Subject: [PATCH] i2c: mv64xxx: Fix circular dependencies warning and
 compilation breakage
In-Reply-To: <20140307142405.GB28943@katana>
References: <20140307111858.GB12274@katana>
 <1394199795-5516-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140307142405.GB28943@katana>
Message-ID: <20140307142614.GC28943@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Why don't you simply set rstc to some ERR_PTR above if not
> RESET_CONTROLLER?

I know why. Sorry for the noise.


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140307/9523e2cf/attachment.sig>
