From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 23 Mar 2017 13:38:40 +0300
Subject: [PATCH v3 2/5] pata_bk3710: disable IORDY Timer on chipset
 initialization
In-Reply-To: <1490206862-26065-3-git-send-email-b.zolnierkie@samsung.com>
References: <1490206862-26065-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20170322182135epcas5p3d21d7301da84a5dcb686af4f6817ded9@epcas5p3.samsung.com>
 <1490206862-26065-3-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <320c278c-85f2-8915-9c69-ad051ef98158@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/22/2017 9:20 PM, Bartlomiej Zolnierkiewicz wrote:

> Disable IORDY Timer as the driver doesn't handle IORDY Timer
> interrupt anyway.
>
> Suggested-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

MBR, Sergei
