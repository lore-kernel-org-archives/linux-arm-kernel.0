From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 16 Jun 2013 12:21:19 +0200
Subject: [PATCH 2/2] regulators: ab3100: bootstrap board power
In-Reply-To: <20130614095454.GF1403@sirena.org.uk>
References: <1371154828-28117-1-git-send-email-linus.walleij@stericsson.com>
 <20130614095454.GF1403@sirena.org.uk>
Message-ID: <CACRpkdbUMxvh2_BmKiKd=cm6TYooFYaWDTQF+o2k2zT9-mKzvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 11:54 AM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Jun 13, 2013 at 10:20:28PM +0200, Linus Walleij wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> This moves the code from the platform that is bootstrapping
>> the power on the U300 platform out from the machine directory
>> and the special-purpose board node and module and into the
>> regulator node and driver itself.
>
> Hrm.  Wouldn't this fit better into the new reset framework?

OK that would anyway involve creating some specific DT node
for this thing I guess.

Then the current approach with a board node is no more
complicated, so we can refactor from that point instead.

Yours,
Linus Walleij
