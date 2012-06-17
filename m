From: olof@lixom.net (Olof Johansson)
Date: Sat, 16 Jun 2012 18:43:14 -0700
Subject: [PATCH] arm: versatile: fix and enable PCI I/O space
In-Reply-To: <1339423438-25836-1-git-send-email-robherring2@gmail.com>
References: <1339423438-25836-1-git-send-email-robherring2@gmail.com>
Message-ID: <20120617014314.GA11547@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 09:03:58AM -0500, Rob Herring wrote:

> Arnd, Olof,
> 
> This should be applied for 3.5. There is a more simple fix to just
> restore IO_RESOURCE_LIMIT to 0xffffffff, but I think that moves in
> the wrong direction. This patch is needed to unify the I/O space
> mapping.

Applied, fixing a trivial stray whitespace.


-Olof
