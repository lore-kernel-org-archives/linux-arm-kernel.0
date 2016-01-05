From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 5 Jan 2016 11:01:10 +0100
Subject: [PATCH] i2c: rk3x: init module as subsys call
In-Reply-To: <568B837B.50607@rock-chips.com>
References: <1451962938-17398-1-git-send-email-jay.xu@rock-chips.com>
 <2513923.8oltbpbAin@phil> <568B73E8.3010901@rock-chips.com>
 <7893052.zgDX0r4i77@phil> <568B837B.50607@rock-chips.com>
Message-ID: <20160105100110.GB1525@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Tomeu from Collabora is working on some better scheme to optimize device 
> > probing order but it looks like this may be a bit off still.

...

> I don't just talk about touch screen driver, most i2c device driver such
> as input sensor/camera/rtc/battery will suffer. So people will see their
> drivers do not work or slow down on rk3368 platform :(

I totally agree that the current situation is not ideal. This is why it
has to be *properly fixed* and not workarounded (which caused other side
effects in the past). If you care about it, then please help Tomeu with
his patchset.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160105/071284c4/attachment.sig>
