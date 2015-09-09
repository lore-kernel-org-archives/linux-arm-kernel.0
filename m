From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 9 Sep 2015 16:05:59 +0200
Subject: [PATCH 0/5] Add eeprom to the Olimex series of boards
In-Reply-To: <1441790715-11957-1-git-send-email-o.schinagl@ultimaker.com>
References: <1441790715-11957-1-git-send-email-o.schinagl@ultimaker.com>
Message-ID: <20150909140559.GD9885@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 09, 2015 at 11:25:10AM +0200, Olliver Schinagl wrote:
> Some of the olimex series of boards feature a permanently connected eeprom on
> i2c-1. This patch series adds them on all the boards that have them according
> to the spec-sheets.
> 
> I explicitly added my personal --Tested-by to boards I actually tested.

Testing your changes is the strict minimum before testing your
patches. Just like running checkpatch on them, which you clearly
failed to do, otherwise you would have seen that this is not the right
syntax. Drop the tested-by, fix your SoB.

> There are two boards, that according to the sheets have them as well
> and physically inspecting the boards shows them clearly, I did not
> actually test them on those the boards that are missing the
> --Tested-by.

Then don't send those patches.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150909/b7a04104/attachment.sig>
