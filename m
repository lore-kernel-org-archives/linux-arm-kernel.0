From: pali.rohar@gmail.com (Pali =?utf-8?B?Um9ow6Fy?=)
Date: Mon, 29 Jun 2015 12:45:53 +0200
Subject: n900 in 4.2-rc0: repeating oopses
In-Reply-To: <20150629091146.GA5103@amd>
References: <20150416093234.GA17423@amd>
 <20150629091146.GA5103@amd>
Message-ID: <20150629104553.GD16230@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Monday 29 June 2015 11:11:46 Pavel Machek wrote:
> Hi!
> 
> Just tried booting 4.2-rc0 on n900 (commit
> 4a10a91756ef381bced7b88cfb9232f660b92d93) and it is broken. Previous
> -rc0 version worked. This time, there's some output on console, but
> too fast for me to read.
> 

What happen after errors are reported? Maybe you can enable R&D mode and
disable HW watchdogs to prevent device reboots...

> It seems oopses happen before mounting root. If you have serial
> console, they should be easy to see.
> 
> I tried booting same kernel in qemu, but it seems to work ok there.
> 

Hm... Maybe problem with HS code?

By chance, can you try to disable (omap) sham node in n900 DT file?
(same way like omap aes is disabled)

> Any ideas? Thanks,
> 									Pavel

-- 
Pali Roh?r
pali.rohar at gmail.com
