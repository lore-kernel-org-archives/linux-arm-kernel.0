From: a.hajda@samsung.com (Andrzej Hajda)
Date: Mon, 06 Mar 2017 15:18:14 +0100
Subject: [Patch v2 03/11] s5p-mfc: Use min scratch buffer size as provided
 by F/W
In-Reply-To: <1488532036-13044-4-git-send-email-smitha.t@samsung.com>
References: <1488532036-13044-1-git-send-email-smitha.t@samsung.com>
 <CGME20170303090440epcas5p33f1bea986f2f9c961c93af94df7ec565@epcas5p3.samsung.com>
 <1488532036-13044-4-git-send-email-smitha.t@samsung.com>
Message-ID: <33a42a78-aaf8-5a57-c58c-62ebd37aa1ca@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03.03.2017 10:07, Smitha T Murthy wrote:
> After MFC v8.0, mfc f/w lets the driver know how much scratch buffer
> size is required for decoder. If mfc f/w has the functionality,
> E_MIN_SCRATCH_BUFFER_SIZE, driver can know how much scratch buffer size
> is required for encoder too.
>
> Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
--
Regards
Andrzej
