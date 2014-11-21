From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 21 Nov 2014 17:47:26 +0100
Subject: [PATCH v4 1/2] i2c: s3c2410: Handle i2c sys_cfg register in i2c
 driver
In-Reply-To: <546F1140.4050709@samsung.com>
References: <1414656270-8048-1-git-send-email-pankaj.dubey@samsung.com>
 <1414656270-8048-2-git-send-email-pankaj.dubey@samsung.com>
 <20141121072545.GG1480@katana> <546F1140.4050709@samsung.com>
Message-ID: <20141121164726.GA1426@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >I usually don't take DTS patches. They should go via arm-soc. Please say
> >so if there are reasons I should take them.
> 
> I CC'ed to you because same patch contains changes in i2c driver.

Yes, those should absolutely go via my I2C tree. You need to make a
seperate patch out of the dts changes which then also should go via
samsung-soc, unless Kukjin says he really wants to go the via I2C. But I
guess the latter will just create merge conflicts.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141121/b415888f/attachment-0001.sig>
