From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 02 Oct 2013 14:05:59 +0200
Subject: [PATCH 3/4] clk: kirkwood: Add CLK_IGNORE_UNUSED to ethernet
 ge0 and ge1 clocks
In-Reply-To: <20131002120256.GH31178@titan.lakedaemon.net>
References: <1380575010-8573-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1380575010-8573-4-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131001004009.GK31178@titan.lakedaemon.net>
 <20131001134213.GC2448@localhost> <524AD2F7.4090803@gmail.com>
 <20131001142205.GF2448@localhost> <524ADFAA.40805@gmail.com>
 <20131001164556.GA23874@obsidianresearch.com> <524B1E12.9080302@gmail.com>
 <20131002120256.GH31178@titan.lakedaemon.net>
Message-ID: <524C0C27.9070107@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/2013 02:02 PM, Jason Cooper wrote:
> On Tue, Oct 01, 2013 at 09:10:10PM +0200, Sebastian Hesselbarth wrote:
> ...
>> before you jump to prepare a patch for the above, I made one based on
>> my previous work and JasonG's suggestions above. Testing it right now,
>> looks promising.
>>
>> @JasonC: To avoid rebase mess again, where do you want it based against?
>
> Just base against v3.12-rc1 and we'll see there's going to be any issues
> with it.  Hopefully, the mv643xx_eth changes can be independent of the
> other changes...

Ok, the mv643xx_eth fixes have been sent as fixes for v3.12 while the
corresponding kirkwood workaround should drop in v3.13. I hopefully find
some time tonight to prepare workaround patches.

Sebastian
