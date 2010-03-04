From: ben@simtec.co.uk (Ben Dooks)
Date: Thu, 04 Mar 2010 23:00:14 +0000
Subject: [PATCH] ARM: s3c2440: mini2440: remove improper __initdata in
	struct s3c2410fb_display
In-Reply-To: <dc447791003011433u48809fb2gf6b3937f2e6eb5d1@mail.gmail.com>
References: <1267399178-11478-1-git-send-email-walsimou@walsimou.com>
	<dc447791003011433u48809fb2gf6b3937f2e6eb5d1@mail.gmail.com>
Message-ID: <4B903B7E.7050500@simtec.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

M P wrote:
> On Sun, Feb 28, 2010 at 11:19 PM, Abdoulaye Walsimou Gaye
> <walsimou@walsimou.com> wrote:
>> This patch remove improper __initdata in struct s3c2410fb_display for for
>> mini2440 board.
>> This __initdata prevents for example directfb to work properly
>> (see below).
>>
> 
> I beleive this patch, and/or something similar is already in the pipe
> from some time.

Please wait until Russell merges for-rmk/samsung5 into mainline and
then send bug reports.

-- 
Ben Dooks, Design & Software Engineer, Simtec Electronics

http://www.simtec.co.uk/
