From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 12 Oct 2015 18:21:07 +0200
Subject: I/O issues with writing to mtdblock devices on kirkwood
In-Reply-To: <461C493B-AD82-4044-A87F-EC22BBFB7011@gmail.com>
References: <1440159857.19360.50.camel@debian.org>
 <20150905210846.GF6040@lunn.ch>
 <CAKzmTe0Bq8itvKoOTwZ+ZjY5pTqFYWt0-ihO4jn0qew_NYGhFg@mail.gmail.com>
 <20151011153548.GA9808@lunn.ch>
 <CAKzmTe2f1FdjM5VZ-ju+ZQ4z0Dxk4x1ywJCfi1OX5eSaCr=51w@mail.gmail.com>
 <461C493B-AD82-4044-A87F-EC22BBFB7011@gmail.com>
Message-ID: <20151012162107.GB3242@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I've been on backports for some time. AFAIR the problems started
> with the change to dtb/dts.

Which kernel version? Can you give me a kernel version when it was
good and a version when it was bad?

For a few kernel versions it was possible to boot both DT and the old
setup file. It would be great to confirm it was the swap to DT, and
not some other kernel change at about the same time.

My gut feeling is that the change to DT is not the issue. But this is
all speculation at the moment, we need some hard evidence.

   Andrew
