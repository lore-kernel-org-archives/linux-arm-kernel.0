From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 15 Jul 2018 14:35:53 +0200
Subject: [PATCH v4 1/5] clk: actions: Add REGMAP as dependency
In-Reply-To: <20180715123145.16975-2-sravanhome@gmail.com>
References: <20180715123145.16975-1-sravanhome@gmail.com>
 <20180715123145.16975-2-sravanhome@gmail.com>
Message-ID: <b0e29fe8-c16a-e783-8877-d01f052ba963@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 15.07.2018 um 14:31 schrieb Saravanan Sekar:
> Add REGMAP as dependency to avoid undefined reference to regmap symbol

Is this a bugfix for S900? Then please add a Fixes: line. If not, why is
it a separate patch and not in 3/5?

Also, the subject is fine as is, but please add a full stop at the end
of the sentence in the commit message.

Regards,
Andreas


-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
