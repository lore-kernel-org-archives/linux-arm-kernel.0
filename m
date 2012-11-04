From: josh.coombs@gmail.com (Josh Coombs)
Date: Sun, 4 Nov 2012 07:05:13 -0500
Subject: Possible regression in 3.7-rc3 on Marvell Kirkwood
In-Reply-To: <20121104091146.GF6832@lunn.ch>
References: <20121103080300.GA9907@lunn.ch>
 <CAMW5UfYmjCq0nnGY6bxV_HxizHSV0UiW74thhers096ufv3E_g@mail.gmail.com>
 <20121103170622.GD6832@lunn.ch>
 <CAMW5UfZLYzCf357Z0Ncd6p5G7VYLwq3nhXVb=nAXZOxONa8yeQ@mail.gmail.com>
 <20121104091146.GF6832@lunn.ch>
Message-ID: <CAMW5UfZoo-7WaBnsqzdmsCu31h3pWb52Y6JX5=jE6H=e80_tJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will do, I'm half curious now if I managed to pull down a copy from
git mid-commit or something, as I can't for the life of me make it
flake out the way it was prior and I see there has been updates to
3.7-rc3 since it was released.  (I always thought once cut, no more
commits went to that branch.)  Oh well, at least my build farm got a
good workout.

Josh C

On Sun, Nov 4, 2012 at 4:11 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Sat, Nov 03, 2012 at 09:39:55PM -0400, Josh Coombs wrote:
>> As of now I can't reproduce, so I can only assume it was something
>> with my config.  Once I nail down exactly what triggers the behavior
>> I'll post up.  For now, ignore my suggestion that there is a
>> regression.
>
> O.K.
>
> I also tried reproducing it.  On my QNAP Kirkwood I made a fresh
> checkout of the kernel and built it. No problems.
>
> If you do see it again, please let us know.
>
> Thanks
>    Andrew
