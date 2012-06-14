From: rubini@gnudd.com (Alessandro Rubini)
Date: Thu, 14 Jun 2012 10:17:58 +0200
Subject: [PATCH V3 2/3] i2c-nomadik: turn the platform driver to an
 amba driver
In-Reply-To: <201206140804.39083.arnd@arndb.de>
References: <201206140804.39083.arnd@arndb.de>
 <cover.1339447570.git.rubini@gnudd.com>
 <4a198618063924b68182279ffd56c335d621f542.1339447570.git.rubini@gnudd.com>
Message-ID: <20120614081758.GA19648@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> You change only one half of ux500 here: the part where the device
> gets defined statically, but not not the definition in the
> device-tree.

Yes, I'm aware. That's why I added Lee Jones as Cc:, on Linusw's
suggestion.  Lee told me to go ahead and he'll fix the DT stuff.
Lee?

thanks
/alessandro
