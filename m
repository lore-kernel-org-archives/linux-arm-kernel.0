From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 28 Oct 2018 21:58:05 +0100 (CET)
Subject: [PATCH RFC 15/18] stagning: vchiq_core: fix logic redundancy in
 parse_open
In-Reply-To: <20181026134813.7775-16-nsaenzjulienne@suse.de>
References: <20181026134813.7775-1-nsaenzjulienne@suse.de>
 <20181026134813.7775-16-nsaenzjulienne@suse.de>
Message-ID: <1557548417.4198.1540760285645@email.ionos.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Nicolas Saenz Julienne <nsaenzjulienne@suse.de> hat am 26. Oktober 2018 um 15:48 geschrieben:
> 
> 
> We update sync to reflect that the firmware version is compatible with
> that option. We don't need to check both of them again further down the
> code.

please fix the typo in the subject s/stagning/staging/ for this patch and patch #4
