From: Jon.Povey@racelogic.co.uk (Jon Povey)
Date: Wed, 20 Apr 2011 02:34:47 +0100
Subject: [PATCH 0/6] i2c-davinci gpio pulsed SCL recovery with ICPFUNC
In-Reply-To: <BANLkTinTMi76GmgO6HJ0+ifCXsHE3Mjsvg@mail.gmail.com>
Message-ID: <70E876B0EA86DD4BAF101844BC814DFE093FB40BBD@Cloud.RL.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben Gardiner wrote:
> In "i2c-davinci: Fix race when setting up for TX" and "i2c-davinci:
> Fix TX setup for more SoCs" you mention testing on DM355 -- is there
> any you have hardware on which the recovery procedure is executed on
> occasion and that you would be available to test modifications to the
> current implementation?

Nope, sorry. I've never seen the bus lock up.

--
Jon Povey
jon.povey at racelogic.co.uk

Racelogic is a limited company registered in England. Registered number 2743719 .
Registered Office Unit 10, Swan Business Centre, Osier Way, Buckingham, Bucks, MK18 1TB .

The information contained in this electronic mail transmission is intended by Racelogic Ltd for the use of the named individual or entity to which it is directed and may contain information that is confidential or privileged. If you have received this electronic mail transmission in error, please delete it from your system without copying or forwarding it, and notify the sender of the error by reply email so that the sender's address records can be corrected. The views expressed by the sender of this communication do not necessarily represent those of Racelogic Ltd. Please note that Racelogic reserves the right to monitor e-mail communications passing through its network
