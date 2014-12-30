From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Dec 2014 23:38:06 +0100
Subject: [PATCH 4/4] ARM: sirf: bring up SMP in atlas7 SoC
In-Reply-To: <1419496460-4929-5-git-send-email-21cnbao@gmail.com>
References: <1419496460-4929-1-git-send-email-21cnbao@gmail.com>
 <1419496460-4929-5-git-send-email-21cnbao@gmail.com>
Message-ID: <1704317.ZimINfER0N@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 December 2014 16:34:20 Barry Song wrote:
> From: Zhiwu Song <Zhiwu.Song@csr.com>
> 
> correct cpu1 jump/flag address, remove scu related logic, scu doesn't
> expose in cortex-a7.
> 
> this patch breaks marco chip, but marco project has been dropped.
> 
> Signed-off-by: Zhiwu Song <Zhiwu.Song@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

It doesn't seem nice to intentionally break hardware that we still have
support for in the kernel. If Marco is not used anywhere, how about
sending another patch before this one to remove all references to it?

	Arnd
