From: bengardiner@nanometrics.ca (Ben Gardiner)
Date: Tue, 19 Apr 2011 08:20:09 -0400
Subject: [PATCH 0/6] i2c-davinci gpio pulsed SCL recovery with ICPFUNC
In-Reply-To: <70E876B0EA86DD4BAF101844BC814DFE093FB40998@Cloud.RL.local>
References: <BANLkTi=7DbMrbo0nQU+268LC_2258q-_DA@mail.gmail.com>
	<70E876B0EA86DD4BAF101844BC814DFE093FB40998@Cloud.RL.local>
Message-ID: <BANLkTinTMi76GmgO6HJ0+ifCXsHE3Mjsvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Mon, Apr 18, 2011 at 9:47 PM, Jon Povey <Jon.Povey@racelogic.co.uk> wrote:
> Ben Gardiner wrote:
>
>>>> When creating this series I noticed that there are obvious
>>>> similarities between the existing recovery routine implemented by
>>>> Philby John and John Povey
>
>> I'm not sure how the 20us in the existing method was derived -- I
>> wonder if Philby John or John Povey could comment?
>
> I've been a little bemused about why I am getting credited for I2C
> bus recovery work. I don't remember doing any work on that.

My mistake -- sorry. Also sorry for getting your name wrong repeatedly.

> I did a couple of patches to fix a race when setting up a TX, but
> those are, afaik, unrelated.

In "i2c-davinci: Fix race when setting up for TX" and "i2c-davinci:
Fix TX setup for more SoCs" you mention testing on DM355 -- is there
any you have hardware on which the recovery procedure is executed on
occasion and that you would be available to test modifications to the
current implementation?

> All I know about the bus recovery stuff is looking at it a while back
> and thinking hmm, that seems to wiggle gpio without changing the
> pinmuxing, so it can't possibly work.

:) Probably not then.

Best Regards,
Ben Gardiner

---
Nanometrics Inc.
http://www.nanometrics.ca
