From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 23 Mar 2017 13:39:28 +0300
Subject: [PATCH v3 3/5] pata_bk3710: clear status bits of BMISP on chipset
 initialization
In-Reply-To: <1490206862-26065-4-git-send-email-b.zolnierkie@samsung.com>
References: <1490206862-26065-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20170322182139epcas5p32d912444c0be8747565a4979f8744572@epcas5p3.samsung.com>
 <1490206862-26065-4-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <bf129198-f778-61d6-07e5-a96c261b08fb@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/22/2017 9:21 PM, Bartlomiej Zolnierkiewicz wrote:

> Clear IORDYINT, INTRSTAT and DMAERROR bits of BMISP register
> (value '1' needs to be written to the bit to clear it).
>
> Suggested-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
[...]

Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

MBR, Sergei
