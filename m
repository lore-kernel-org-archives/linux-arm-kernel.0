From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 20 Sep 2011 12:02:14 +0100
Subject: Link failures due to __bug_table in current -next
In-Reply-To: <20110919200317.GC16381@n2100.arm.linux.org.uk>
References: <20110919120954.GA20314@opensource.wolfsonmicro.com>
	<20110919200317.GC16381@n2100.arm.linux.org.uk>
Message-ID: <20110920110214.GH2387@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2011 at 09:03:17PM +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 19, 2011 at 01:09:54PM +0100, Mark Brown wrote:

> > `.exit.text' referenced in section `__bug_table' of net/built-in.o:
> > defined in discarded section `.exit.text' of net/built-in.o

> This might solve the problem - could you check please?

Yes, that works for me - thanks!
