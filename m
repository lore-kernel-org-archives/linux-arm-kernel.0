From: giometti@enneenne.com (Rodolfo Giometti)
Date: Thu, 9 Jan 2014 17:33:26 +0100
Subject: NAND support for Armada 370
In-Reply-To: <20140108233603.GB2595@localhost>
References: <20140102124407.GF10251@enneenne.com>
 <20140102144236.270c4a6a@skate>
 <20140103112926.GP10251@enneenne.com>
 <20140103145336.GA9618@localhost>
 <20140106153438.GX10251@enneenne.com>
 <20140108233603.GB2595@localhost>
Message-ID: <20140109163326.GD17831@enneenne.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 08:36:03PM -0300, Ezequiel Garcia wrote:
> Hi Rodolfo,
> 
> Sorry for being so unresponsive these days, I've been on vacation.
> I'll review your patch on Monday.

Ok.

> In fact, already took a quick look and it looks good. I have a few
> doubts:
> 
> 1. Do we need the ECC layout? (MTD already provides defaults)

Ok, I did some testes and we can safely remove it! :)

> 2. Is this compatible with Marvell's U-Boot? (can you write from U-Boot,
> and read from Linux, and viceversa?)

Till now all our tests are ok! :)

Attached is the new patch release.

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti at enneenne.com
Linux Device Driver                          giometti at linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-mtd-pxa3xx_nand.c-add-support-for-2048-bytes-page-si.patch
Type: text/x-diff
Size: 1192 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140109/2c993927/attachment.bin>
