From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Sep 2010 11:01:11 +0100
Subject: Maximum bootable kernel size in current ARM linux
In-Reply-To: <4C8DD588.7040009@endruntechnologies.com>
References: <4C8DD588.7040009@endruntechnologies.com>
Message-ID: <20100913100111.GA30787@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 13, 2010 at 12:40:56AM -0700, Bruce M. Penrod wrote:
> This seems like a pretty straightforward question, but extensive web  
> searching hasn't shown a really clear, up-to-date answer.  The most  
> recent info is circa 2004 and states that 4MB is the largest  
> uncompressed ARM kernel that may be loaded.  Not being an ARM assembly  
> guru (head.S baffles me), I'd like to know if that is still true in  
> 2010, and if it is, why?

It is no longer true; the only limit now is the size of contiguous RAM
to fit the kernel image into.
