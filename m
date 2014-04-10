From: horms@verge.net.au (Simon Horman)
Date: Thu, 10 Apr 2014 18:09:27 +0900
Subject: [PATCH] ARM: shmobile: Enable USB [EO]HCI HCD support in
 shmobile_defconfig
In-Reply-To: <CANqRtoQ8-zRY1eCTF9uDzWi+dCaKPBdnmhTrOL8UgztHcVMj7w@mail.gmail.com>
References: <1397115230-18437-1-git-send-email-horms+renesas@verge.net.au>
 <CANqRtoQ8-zRY1eCTF9uDzWi+dCaKPBdnmhTrOL8UgztHcVMj7w@mail.gmail.com>
Message-ID: <20140410090925.GA25702@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 04:35:45PM +0900, Magnus Damm wrote:
> Hi Simon,
> 
> On Thu, Apr 10, 2014 at 4:33 PM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > The USB [EO]HCI HCD drivers provide USB host support for Renesas
> > R-Car Gen2 platforms. To increase hardware support enable the driver in the
> > shmobile_defconfig multiplatform configuration.
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Thanks, this configuration is useful for both DT and platform device support.
> 
> Acked-by: Magnus Damm <damm@opensource.se.>

Thanks, I will queue this up.
