From: giometti@enneenne.com (Rodolfo Giometti)
Date: Mon, 6 Jan 2014 16:34:38 +0100
Subject: NAND support for Armada 370
In-Reply-To: <20140103145336.GA9618@localhost>
References: <20140102124407.GF10251@enneenne.com>
 <20140102144236.270c4a6a@skate>
 <20140103112926.GP10251@enneenne.com>
 <20140103145336.GA9618@localhost>
Message-ID: <20140106153438.GX10251@enneenne.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 03, 2014 at 11:53:37AM -0300, Ezequiel Garcia wrote:
> 
> Can you modify the above message so the ECC step size is also printed?
> I'll help you prepare a suitable fix to support your NAND.

After some attemps I found this configuration... however I'd like to
have your opinion about it since I'm not so sure that I correctly
understood what each parameter means. :-)

Thanks in advance,

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
Size: 1656 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140106/af46e3dc/attachment.bin>
