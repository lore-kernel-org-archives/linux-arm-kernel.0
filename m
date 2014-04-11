From: carlo@caione.org (Carlo Caione)
Date: Fri, 11 Apr 2014 14:29:30 +0200
Subject: [linux-sunxi] Re: [PATCH v4 6/9] regulator: AXP20x: Add support
 for regulators subsystem
In-Reply-To: <20140411122345.GD28800@sirena.org.uk>
References: <1397209093-10077-1-git-send-email-carlo@caione.org>
 <1397209093-10077-7-git-send-email-carlo@caione.org>
 <20140411122345.GD28800@sirena.org.uk>
Message-ID: <CAOQ7t2Y8tN6i7MtT_QkrxZsLzJi-53MmUcC9c1GJscreniStXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 11, 2014 at 2:23 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Apr 11, 2014 at 11:38:10AM +0200, Carlo Caione wrote:
>> AXP202 and AXP209 come with two synchronous step-down DC-DCs and five
>> LDOs. This patch introduces basic support for those regulators.
>
> Applied, thanks, but I had to resolve some trivial add/add conflicts
> with the Broadcom regulator driver Makefile and Kconfig additions -
> please remember to submit patches against current code.

Sorry, I'll do next time.

Thank you,

-- 
Carlo Caione
