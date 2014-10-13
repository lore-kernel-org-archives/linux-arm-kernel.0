From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Mon, 13 Oct 2014 07:49:19 -0700
Subject: Regarding tx-nocache-copy in the Sheevaplug
In-Reply-To: <20141013143138.GJ1972@vicerveza.homeunix.net>
References: <20141013105246.GD1972@vicerveza.homeunix.net>
 <20141013142156.GE26864@lunn.ch>
 <20141013143138.GJ1972@vicerveza.homeunix.net>
Message-ID: <1413211759.9362.103.camel@edumazet-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-10-13 at 16:31 +0200, Llu?s Batlle i Rossell wrote:
> Enabling tx offload and disabling tx-nocache-copy, making the machine *send* a
> lot of ssh traffic (sftp for example) makes ssh fail HMAC. It's quite easy to
> reproduce here.
> 
> As for the hardware, it's an old sheevaplug board.


Have you tried disabling TSO only, and are you using the latest kernel ?

Ezequiel Garcia added lot of changes recently.
