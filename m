From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 5 Dec 2013 17:21:50 -0500 (EST)
Subject: [PATCH 0/5] PM: Enable option of re-use runtime PM callbacks at
 system suspend
In-Reply-To: <CAJvTdKnqD3ccPUzh7kNMNqrEYFfD93Vh9hgFuKyHz+pjGNHdtA@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1312051720330.869-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 5 Dec 2013, Len Brown wrote:

> This thread raises the question...
> 
> Do we still need to have PM_RUNTIME apart from PM_SLEEP?
> 
> What is the benefit of being able to build-in one one without the other?
> If that benefit is not significant, perhaps the time has come to
> replace them both with CONFIG_PM...

There are lots of embedded/SoC platforms that implement PM_RUNTIME but
not PM_SLEEP.

Alan Stern
