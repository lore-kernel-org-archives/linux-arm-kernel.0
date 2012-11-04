From: josh.coombs@gmail.com (Josh Coombs)
Date: Sat, 3 Nov 2012 21:39:55 -0400
Subject: Possible regression in 3.7-rc3 on Marvell Kirkwood
In-Reply-To: <20121103170622.GD6832@lunn.ch>
References: <20121103080300.GA9907@lunn.ch>
 <CAMW5UfYmjCq0nnGY6bxV_HxizHSV0UiW74thhers096ufv3E_g@mail.gmail.com>
 <20121103170622.GD6832@lunn.ch>
Message-ID: <CAMW5UfZLYzCf357Z0Ncd6p5G7VYLwq3nhXVb=nAXZOxONa8yeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of now I can't reproduce, so I can only assume it was something
with my config.  Once I nail down exactly what triggers the behavior
I'll post up.  For now, ignore my suggestion that there is a
regression.

Josh C

On Sat, Nov 3, 2012 at 1:06 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Sat, Nov 03, 2012 at 08:54:21AM -0400, Josh Coombs wrote:
>> I'll fire up with ignore log level to get the full traces and post
>> those this afternoon.  Given it will be a LOT of text, would you
>> prefer I include them in the email, pastebin the output and provide
>> links, or dump the log onto my webserver with a link?
>
> Hi Josh
>
> I'm kind of expecting they will all look very similar. By looking at
> what is common it might quick become clear where the lock is being
> taken which is causing the problem.
>
> Anyway, i would suggest posting the first couple of traces to the list
> and a few more to me directly.
>
>     Andrew
