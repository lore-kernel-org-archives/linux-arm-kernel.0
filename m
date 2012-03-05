From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 5 Mar 2012 17:44:09 -0600
Subject: [PATCH 0/9] DMA engine cookie handling cleanups
In-Reply-To: <CACRpkda9R3c0dt95w0N7Fe5es16CqbWtsCKMaFq-nwSYV4bk-w@mail.gmail.com>
References: <20120305201411.GA17791@n2100.arm.linux.org.uk>
 <CACRpkda9R3c0dt95w0N7Fe5es16CqbWtsCKMaFq-nwSYV4bk-w@mail.gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F41FF555B5@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, March 05, 2012 1:51 PM, Linus Walleij wrote:
> On Mon, Mar 5, 2012 at 9:14 PM, Russell King - ARM Linux wrote:
>
>> This patch series cleans up the handling of cookies in DMA engine drivers.
>> This is done by providing a set of inline library functions for common
>> tasks:
>
> Overall this looks good, but I have a problem:
> patch [1/9] does not appear in any subscribed accounts (it may be on
> my @stericsson.com address, will check tomorrow)

Patch 8/9 also doesn't appear to be on the mailing list.

> One I get hold of an ungmangled copy I can test the series on
> ux500 and U300.
>
> Is it just stuck in moderation because of size or something like that?

I'm also trying to test the series on ep93xx but have some compile issues
with patches [3/9] and [6/9].

Regards,
Hartley
