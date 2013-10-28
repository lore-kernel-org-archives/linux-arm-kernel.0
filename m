From: olof@lixom.net (Olof Johansson)
Date: Mon, 28 Oct 2013 15:09:23 -0700
Subject: Heads up: Mostly done with 3.13 arm-soc merges now
Message-ID: <CAOesGMhRDOdEjEQz+-0_ecuDSqMi+dn6LSU=UJZtGLriyFbBtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Since -rc7 is behind us, and the final 3.12 might be just a few days
away, it's high time to start pulling the brakes on new pull requests.

I've swept through and done the backlog that's pending. I have only a
few ones still in mind to apply -- I've asked for some quick respins
today for a couple of small branches and one to remove the platform
name from DT_MACHINE entries from Rob Herring.

So, if you think you've got a pull request that we've missed, speak up
as soon as possible and we'll take a look at it.

As usual we might take smaller incremental changes for critical stuff
still, but we shouldn't be seeing any new major pull requests until
after the merge window (or if we do, we might choose to queue them for
3.14 instead).


-Olof
