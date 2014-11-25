From: will.deacon@arm.com (Will Deacon)
Date: Tue, 25 Nov 2014 15:33:25 +0000
Subject: [PATCHv6 0/8] Better page protections for arm64
In-Reply-To: <1416606645-25633-1-git-send-email-lauraa@codeaurora.org>
References: <1416606645-25633-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <20141125153325.GG8541@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 21, 2014 at 09:50:37PM +0000, Laura Abbott wrote:
> Hi,

Hi Laura,

> This is v6 of the series to add stricter page protections for arm64.
> The goal is to have text be RO/NX and everything else be RW/NX.
> The biggest change here is the addition of ioremap_exec for EFI
> services. The series did its job and caught EFI services trying to
> use regular RAM for code purposes.

I've taken patches 1-3 + 5 of this series. I appreciate that the `meat' is
in the later parts of the series, but I think there's still some review
needed there and it makes sense to take the independent parts first.

Cheers,

Will
