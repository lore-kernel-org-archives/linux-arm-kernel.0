From: horms@verge.net.au (Simon Horman)
Date: Wed, 15 Jul 2015 15:55:16 +0900
Subject: [PATCH] ARM: shmobile: Enable fixed voltage regulator in
 shmobile_defconfig
In-Reply-To: <CANqRtoT=8Oyr2Bb10dnvQAe0LzMsQk3VZw6ZN5YSJ=UDcBnLSQ@mail.gmail.com>
References: <1436942555-4851-1-git-send-email-horms+renesas@verge.net.au>
 <CANqRtoT=8Oyr2Bb10dnvQAe0LzMsQk3VZw6ZN5YSJ=UDcBnLSQ@mail.gmail.com>
Message-ID: <20150715065516.GD5071@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 15, 2015 at 03:47:59PM +0900, Magnus Damm wrote:
> Hi Simon,
> 
> On Wed, Jul 15, 2015 at 3:42 PM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > This is selected by MACH_MARZEN which is enabled in shmobile_defconfig,
> > however, MACH_MARZEN is going away along with the board code it enables.
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Thanks for dealing with this, looking good!

Thanks, I will shuffle things a bit so this is queued up before the patch
that removes the marzen-reference board code and MACH_MARZEN.
