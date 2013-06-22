From: gsi@denx.de (Gerhard Sittig)
Date: Sat, 22 Jun 2013 10:22:07 +0200
Subject: [PATCH v1 02/12] input: matrix-keymap: func call coding style nit
In-Reply-To: <201306220418.59722.marex@denx.de>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
 <1371838198-7327-3-git-send-email-gsi@denx.de>
 <201306220418.59722.marex@denx.de>
Message-ID: <20130622082207.GC24305@book.gsilab.sittig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 22, 2013 at 04:18 +0200, Marek Vasut wrote:
> 
> ret = matrix_keypad_map_key(input_dev, rows, cols, row_shift, key);
> if (ret)
> 	return ret;
> 
> Now that you return correct error codes from above, you should propagate them 
> through.

Will do, queued for v2.  Thank you for reviewing this.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
