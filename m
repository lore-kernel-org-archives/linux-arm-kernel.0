From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 26 Mar 2015 13:27:08 +0000
Subject: [Linux-kernel] atmel dma endian fixes
In-Reply-To: <1427375191-1467-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1427375191-1467-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <5514092C.9090303@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/03/15 13:06, Ben Dooks wrote:
> Hi, these three fix the endian issues i've found so far when doing big
> endain work on the ATSAMA5D36.

It looks like the at_hdmac patch needs to be re-done after -rc5 so I
will re-send once this is tested.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
