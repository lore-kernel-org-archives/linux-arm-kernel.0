From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 31 Jul 2013 20:39:30 +0100
Subject: [PATCH] ARM: Fix memblock_reserve() to include stext
In-Reply-To: <CANqRtoR5j2VyRwf0suABfVLxzU30pZndEcCj7uZ2sSrzfGmx_A@mail.gmail.com>
References: <20130731055807.14054.70106.sendpatchset@w520>
 <20130731094352.GV24642@n2100.arm.linux.org.uk>
 <CANqRtoR5j2VyRwf0suABfVLxzU30pZndEcCj7uZ2sSrzfGmx_A@mail.gmail.com>
Message-ID: <20130731193930.GY24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 01, 2013 at 04:34:03AM +0900, Magnus Damm wrote:
> Are you aware of any existing fix for this or anyone working on
> solving this issue? If not then I don't mind stepping up. I can
> however think of quite a few other things to do if this has been
> solved already though, so please let me know if you think I should
> focus on fixing this.

I committed a fix for it this morning, so it should be in linux-next by
tomorrow.
