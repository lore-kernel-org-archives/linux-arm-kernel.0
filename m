From: sebastian@breakpoint.cc (Sebastian Andrzej Siewior)
Date: Tue, 18 Dec 2012 15:15:07 +0100
Subject: 3.7 kernel hangs when doing scp
In-Reply-To: <CAOMZO5Bc5stXXviuf3OL9vAHw+ER=GzzV1q=5Yr5q=AnfoGiGw@mail.gmail.com>
References: <CAOMZO5Bc5stXXviuf3OL9vAHw+ER=GzzV1q=5Yr5q=AnfoGiGw@mail.gmail.com>
Message-ID: <20121218141507.GC4939@breakpoint.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 18, 2012 at 12:01:35AM -0200, Fabio Estevam wrote:
> Booting a 3.7 kernel on a mx6qsabrelite board via NFS and using an
> asix USB/Ethernet adapter and then I try to transfer a 10MB file from
> the target to the host:

That backtrace shows only that nothing is going on. Can you attach that asix
thingy to another USB-host and test?
Is your host working well with other devices say usb-storage?

Sebastian
