From: olof@lixom.net (Olof Johansson)
Date: Fri, 23 Jan 2015 15:06:09 -0800
Subject: [GIT PULL] at91: cleanup/soc for 3.20 #3
In-Reply-To: <1422033307-9702-1-git-send-email-nicolas.ferre@atmel.com>
References: <1422033307-9702-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20150123230609.GV20896@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 23, 2015 at 06:15:07PM +0100, Nicolas Ferre wrote:
> Arnd, Olof, Kevin,
> 
> This is a batch of cleanup/soc modifications that you may also stack on top of
> your "soc" branch as the previous one. It stabilizes a little bit our cleanup
> action before going further.
> I also have the feeling that multi-platform would be hard to reach for 3.20...
> 
> Thanks, best regards,
> 
> The following changes since commit 29ee506d0d56f6d39cc237de2512f9cb5629cbf7:
> 
>   ARM: at91: move at91rm9200_idle() to clk/at91/pmc.c (2015-01-16 18:08:42 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-cleanup3
> 
> for you to fetch changes up to d7b943cd96a1196a7e4f8ae48fc16a086ccc9a6a:
> 
>   ARM: at91: pm: remove warning to remove SOC_AT91SAM9263 usage (2015-01-23 12:35:50 +0100)
> 

Hi,

I had a comment on the very first patch in this branch, so please address that
and send a fresh pull request.


Thanks,

-Olof
