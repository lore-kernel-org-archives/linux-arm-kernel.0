From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 02 Mar 2015 21:48:04 +0100
Subject: [PATCH 00/10] ARM: s3c64xx multiplatform, help needed
In-Reply-To: <1425299763-4066822-1-git-send-email-arnd@arndb.de>
References: <1425299763-4066822-1-git-send-email-arnd@arndb.de>
Message-ID: <4881827.s58SBDBL3P@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 March 2015 13:35:53 Arnd Bergmann wrote:
> Hi everyone,
> 
> I've had these patches in a private git tree for a while, and have
> finally gotten around to clean them up some more for submission.
> Hopefully we can get all of it merged into 4.1.
> 
> I've done this to the best of my knowledge, but some parts are
> a bit tricky, so I expect that there are bugs. The trickiest
> part is the touchscreen driver. I've sent it out for review
> last year already, but I have not found anybody who could test
> it, and it's basically a blind rewrite of an existing driver,
> so it's unlikely that I got it all right.
> 
> The other parts may actually work, but it is possible that
> I made a mistake with the ASoC driver, the sparseirq support
> or something else.
> 
> Does anyone still have access to the hardware? I'm particularly
> interested in seeing this patch set get tested on smartq
> and on smdk6410, which have the majority of the hardware.
> 

I should have mentioned, this series (and the respective bits
for realview, mmp, and orion) is now at
http://git.kernel.org/cgit/linux/kernel/git/arnd/playground.git/log/?h=multiplatform-4.0-rc1

	Arnd
