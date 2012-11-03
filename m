From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 3 Nov 2012 18:06:22 +0100
Subject: Possible regression in 3.7-rc3 on Marvell Kirkwood
In-Reply-To: <CAMW5UfYmjCq0nnGY6bxV_HxizHSV0UiW74thhers096ufv3E_g@mail.gmail.com>
References: <20121103080300.GA9907@lunn.ch>
 <CAMW5UfYmjCq0nnGY6bxV_HxizHSV0UiW74thhers096ufv3E_g@mail.gmail.com>
Message-ID: <20121103170622.GD6832@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 03, 2012 at 08:54:21AM -0400, Josh Coombs wrote:
> I'll fire up with ignore log level to get the full traces and post
> those this afternoon.  Given it will be a LOT of text, would you
> prefer I include them in the email, pastebin the output and provide
> links, or dump the log onto my webserver with a link?

Hi Josh

I'm kind of expecting they will all look very similar. By looking at
what is common it might quick become clear where the lock is being
taken which is causing the problem.

Anyway, i would suggest posting the first couple of traces to the list
and a few more to me directly.

    Andrew
