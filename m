From: roger.pau@citrix.com (=?UTF-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?=)
Date: Wed, 20 May 2015 16:54:56 +0200
Subject: [RFC 06/23] block/xen-blkback: s/nr_pages/nr_segs/
In-Reply-To: <1431622863-28575-7-git-send-email-julien.grall@citrix.com>
References: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
 <1431622863-28575-7-git-send-email-julien.grall@citrix.com>
Message-ID: <555CA040.9070503@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El 14/05/15 a les 19.00, Julien Grall ha escrit:
> From: Julien Grall <julien.grall@linaro.org>
> 
> Make the code less confusing to read now that Linux may not have the
> same page size as Xen.
> 
> Signed-off-by: Julien Grall <julien.grall@citrix.com>

Acked-by: Roger Pau Monn? <roger.pau@citrix.com>
