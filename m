From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Fri, 18 Mar 2011 10:06:41 +0200
Subject: [GIT PULL] omap changes for v2.6.39 merge window
In-Reply-To: <20110318070935.GC3555@atomide.com>
References: <20110317183048.GW7258@atomide.com>
	<AANLkTik_Y1uMfVTVVEdPFG0sjW2uYpeeUMKfymho3sd+@mail.gmail.com>
	<20110318070935.GC3555@atomide.com>
Message-ID: <AANLkTin-dwhmFjF=g90tMvGMS1hv-cod9WrQiaLfYygS@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2011 at 9:09 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Linus Torvalds <torvalds@linux-foundation.org> [110317 20:00]:
>> Make platforms that need it "select" it or something. It looks like
>> nobody but an OMAP4 could _possibly_ ever want to answer 'y' to that
>> question, SO DON'T ASK IT!
>
> No problem, let's make it depends on OMAP4.

(patch also attached in case gmail eats my whitespace)
