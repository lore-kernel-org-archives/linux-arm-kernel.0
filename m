From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 13 Feb 2017 06:20:47 +0100
Subject: [PATCH v2] arm64: use is_vmalloc_addr
In-Reply-To: <1486640734-27637-1-git-send-email-miles.chen@mediatek.com>
References: <1486640734-27637-1-git-send-email-miles.chen@mediatek.com>
Message-ID: <ba5aeff9-4a02-8f5a-c5e4-e06c437875fc@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 09.02.2017 um 12:45 schrieb Miles Chen:
> To is_vmalloc_addr() to check if an address is a vmalloc address

"Use ..."?

Regards,
Andreas

> instead of checking VMALLOC_START and VMALLOC_END manually.
> 
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
