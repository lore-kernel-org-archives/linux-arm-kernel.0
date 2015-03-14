From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 14 Mar 2015 12:14:51 +0100
Subject: [RFC V2 00/12] i2c: describe adapter quirks in a generic way
In-Reply-To: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
Message-ID: <20150314111450.GC970@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 05:01:51PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Here is the second version of the patch series to describe i2c adapter quirks
> in a generic way. For the motivation, please read description of patch 1. This
> is still RFC because I would like to do some more tests on my own, but I need
> to write a tool for that. However, I'd really like to have the driver authors
> to have a look already. Actual testing is very much appreciated. Thanks to the
> Mediatek guys for rebasing their new driver to this framework. That helps, too!

Thanks for all the testing. Merged this branch now into for-next!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150314/f24f3abe/attachment.sig>
