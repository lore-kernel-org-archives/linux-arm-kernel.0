From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Aug 2012 10:16:22 +0000
Subject: [PATCH 2/3] ARM: PRIMA2: make mach-prima2 common for all SiRF
 series SoC
In-Reply-To: <CAGsJ_4zBEgexWBWsKCe2UtfP1m7BSMO9dq8thi3oQVYsq22v+A@mail.gmail.com>
References: <1345450787-17246-1-git-send-email-Barry.Song@csr.com>
 <CAGsJ_4ynJjm6WuA6NGZdOgj80Xc=ZxKcRatQuEacVW=EXuxh=w@mail.gmail.com>
 <CAGsJ_4zBEgexWBWsKCe2UtfP1m7BSMO9dq8thi3oQVYsq22v+A@mail.gmail.com>
Message-ID: <201208211016.22511.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 August 2012, Barry Song wrote:
> i would think merging several SoCs into a dir still needs much time.
> if the whole rename is too aggresive for the moment, how about keeping
> the mach-prima2 temporarily, but this prima2 dir will also include the
> coming Marco stuff?
> 

Yes, that is what I meant. Sorry if I wasn't clear on that. Please send
the marco patches adding the code in the mach-prima2 directory.


	Arnd
