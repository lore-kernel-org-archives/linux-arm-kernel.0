From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 8 May 2012 14:33:38 +0200
Subject: Handling of modular boards
In-Reply-To: <20120504204455.GR14230@opensource.wolfsonmicro.com>
References: <20120504185850.GO14230@opensource.wolfsonmicro.com>
 <4FA432E9.9050606@wwwdotorg.org>
 <20120504204455.GR14230@opensource.wolfsonmicro.com>
Message-ID: <CACRpkdbyp=BNGn8Eub6vcAgB9CS5PhYcGt2foi8kNxA3oU5Fzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 4, 2012 at 10:44 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, May 04, 2012 at 01:50:01PM -0600, Stephen Warren wrote:
>
>> b) Doesn't integrate well with hotplug; the DT for the board
>> configuration is static at boot. What if a board can be unplugged and
>> another plugged in; a reboot or similar would be needed to adjust the
>> kernel to this.
>
> This is another issue - a similar set of problems does apply to some PCI
> type cards where the PCI device is essentially a bridge to a typical
> embedded system - though practically speaking it's much less severe.

I think Alessandro is working on a board like that right now, so looping
in Ale to this discussion to get his attention...

Linus Walleij
