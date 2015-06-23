From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 23 Jun 2015 22:03:16 +0200
Subject: [PATCH 7/8] cpufreq: st: Provide runtime initialised driver for
 ST's platforms
In-Reply-To: <20150623082857.GG3245@x1>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
 <1434987837-24212-8-git-send-email-lee.jones@linaro.org>
 <1435046411.4528.6.camel@tiscali.nl> <20150623082857.GG3245@x1>
Message-ID: <1435089796.4528.53.camel@tiscali.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-06-23 at 09:28 +0100, Lee Jones wrote:
> BTW, do you have a script that does this now, or are you still
> hand-rolling these?

There was a script detecting Kconfig problems that is basically
retired. (The messages I sent were always manually written.) That
script's function is now performed, much better, by the undertaker
-checkpatch bot (courtesy of a group of people apparently all
affiliated with the university of Erlangen, Germany). We're in virtual
contact but that group is doing fine so I'm basically not contributing.

Anyhow, my reply to your patch was the result of a manual scan for a
small set of common (and mostly trivial) mistakes in patches that I try
to do regularly. All pretty basic stuff, otherwise I wouldn't been able
to spot these mistakes.

Does this answer your question?


Paul Bolle
