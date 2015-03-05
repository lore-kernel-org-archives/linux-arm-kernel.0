From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Thu, 05 Mar 2015 15:27:05 +0200
Subject: [RFC V2 00/12] i2c: describe adapter quirks in a generic way
In-Reply-To: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1425562025.5705.24.camel@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Wed, 2015-02-25 at 17:01 +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Here is the second version of the patch series to describe i2c adapter quirks
> in a generic way. For the motivation, please read description of patch 1. This
> is still RFC because I would like to do some more tests on my own, but I need
> to write a tool for that. However, I'd really like to have the driver authors
> to have a look already. Actual testing is very much appreciated. Thanks to the
> Mediatek guys for rebasing their new driver to this framework. That helps, too!
> 
> The branch is also here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/quirks
> 
> Thanks,
> 
>    Wolfram
> 
> Major changes since V1:
> 
> * more fine-grained options to describe modes with combined messages.
>   This should also cover the Mediatek HW now as well as all other
>   permutations I can think of.
> 
> * the core code and at91 driver had to be refactored to reflect the
>   above change
> 
> * added the bcm-iproc driver which came to mainline recently
> 
> Wolfram Sang (12):
>   i2c: add quirk structure to describe adapter flaws
>   i2c: add quirk checks to core
>   i2c: at91: make use of the new infrastructure for quirks
>   i2c: opal: make use of the new infrastructure for quirks
>   i2c: qup: make use of the new infrastructure for quirks
> 

For QUP driver. 

Reviewed-by: Ivan T. Ivanov <iivanov@mm-sol.com>
Tested-by: Ivan T. Ivanov <iivanov@mm-sol.com>

Thanks,
Ivan
