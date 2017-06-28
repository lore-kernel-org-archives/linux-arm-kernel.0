From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Jun 2017 19:42:28 +0100
Subject: [PATCH v3 2/2] spi: rockchip: Disable Runtime PM when chip
 select is asserted
In-Reply-To: <CAD=FV=UzDHfTNJgs8vvbKGd0RpY__Q9V27aSQiR5ugv6ff5gfQ@mail.gmail.com>
References: <1498624723-17332-1-git-send-email-jeffy.chen@rock-chips.com>
 <1498624723-17332-2-git-send-email-jeffy.chen@rock-chips.com>
 <CAD=FV=UzDHfTNJgs8vvbKGd0RpY__Q9V27aSQiR5ugv6ff5gfQ@mail.gmail.com>
Message-ID: <20170628184228.qdj7oslnljv6e2iy@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 27, 2017 at 10:30:10PM -0700, Doug Anderson wrote:
> Jeffy,
> 
> On Tue, Jun 27, 2017 at 9:38 PM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
> > The rockchip spi would stop driving pins when runtime suspended, which
> > might break slave's xfer(for example cros_ec).

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170628/1913af90/attachment.sig>
