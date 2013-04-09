From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 9 Apr 2013 17:28:47 -0300
Subject: [PATCH v4 1/5] drivers: memory: Introduce Marvell EBU Device Bus
 driver
In-Reply-To: <20130409160316.GB9663@obsidianresearch.com>
References: <1365419194-20871-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1365419194-20871-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130408171940.GA8815@obsidianresearch.com>
 <20130409004253.GA2258@localhost>
 <20130409160316.GB9663@obsidianresearch.com>
Message-ID: <20130409202845.GA2251@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Tue, Apr 09, 2013 at 10:03:16AM -0600, Jason Gunthorpe wrote:
> 
> No need to look at children at all. You can remove all the child
> parsing code, and then the driver is able to handle a wider range of
> possible DT uses.
> 

Agreed. I just sent a v6 fixing this and using of_platform_populate()
to create every child available.

How does it look?

Thanks for the feedback!
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
