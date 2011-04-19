From: Jon.Povey@racelogic.co.uk (Jon Povey)
Date: Tue, 19 Apr 2011 02:47:53 +0100
Subject: [PATCH 0/6] i2c-davinci gpio pulsed SCL recovery with ICPFUNC
In-Reply-To: <BANLkTi=7DbMrbo0nQU+268LC_2258q-_DA@mail.gmail.com>
Message-ID: <70E876B0EA86DD4BAF101844BC814DFE093FB40998@Cloud.RL.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben Gardiner wrote:

>>> When creating this series I noticed that there are obvious
>>> similarities between the existing recovery routine implemented by
>>> Philby John and John Povey

> I'm not sure how the 20us in the existing method was derived -- I
> wonder if Philby John or John Povey could comment?

I've been a little bemused about why I am getting credited for I2C
bus recovery work. I don't remember doing any work on that.

I did a couple of patches to fix a race when setting up a TX, but
those are, afaik, unrelated.

All I know about the bus recovery stuff is looking at it a while back
and thinking hmm, that seems to wiggle gpio without changing the
pinmuxing, so it can't possibly work.

--
Jon Povey
jon.povey at racelogic.co.uk

Racelogic is a limited company registered in England. Registered number 2743719 .
Registered Office Unit 10, Swan Business Centre, Osier Way, Buckingham, Bucks, MK18 1TB .

The information contained in this electronic mail transmission is intended by Racelogic Ltd for the use of the named individual or entity to which it is directed and may contain information that is confidential or privileged. If you have received this electronic mail transmission in error, please delete it from your system without copying or forwarding it, and notify the sender of the error by reply email so that the sender's address records can be corrected. The views expressed by the sender of this communication do not necessarily represent those of Racelogic Ltd. Please note that Racelogic reserves the right to monitor e-mail communications passing through its network
