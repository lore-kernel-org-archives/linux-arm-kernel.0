From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 3 Aug 2018 12:48:11 +0200
Subject: [PATCH] ARM: shmobile: silk: Add DA9063 PMIC node
In-Reply-To: <75d2797a-48db-4979-c059-d7359eb39cff@gmail.com>
References: <20180730111817.5636-1-marek.vasut+renesas@gmail.com>
 <CAMuHMdXib8fz3c41RX-70eA5w4ThM6e02ybmX=N=xXR6=F80KA@mail.gmail.com>
 <42d09bc8-a883-c3af-b0d6-0087b6e2558e@gmail.com>
 <CAMuHMdXSjLSsmU32tKo5tkS6+MipAXuVAUqkLYrXxmR07+eCEg@mail.gmail.com>
 <75d2797a-48db-4979-c059-d7359eb39cff@gmail.com>
Message-ID: <20180803104811.2kfa456t7ytcft6s@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Wolfram: do you like i2c slaves connected to multiple buses?

'Like' would be an exaggeration, but if they are connected to multiple
busses, this might be a reason to describe that. People could then in
userspace bind/unbind to the bus they want? Not pretty, but there might
be reasons for that?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180803/bc0b119e/attachment.sig>
