From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Sun, 11 Dec 2016 20:12:13 +0530
Subject: [PATCH RFC 2/2] ARM: nommu: remap exception base address to RAM
In-Reply-To: <20161211131255.3221-1-afzal.mohd.ma@gmail.com>
References: <20161211131028.3019-1-afzal.mohd.ma@gmail.com>
 <20161211131255.3221-1-afzal.mohd.ma@gmail.com>
Message-ID: <20161211144213.GA3199@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Dec 11, 2016 at 06:42:55PM +0530, Afzal Mohammed wrote:

> Kernel text start at an offset of at least 32K to account for page
> tables in MMU case.

Proper way to put it might have been "32K (to account for 16K initial
page tables & the old atags)", unless i missed something.

Regards
afzal
