From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 20 Mar 2017 15:26:33 +0100
Subject: [PATCH] staging: vc04_services: fix NULL pointer dereference on
 pointer 'service'
In-Reply-To: <20170320140850.10570-1-colin.king@canonical.com>
References: <20170320140850.10570-1-colin.king@canonical.com>
Message-ID: <b6549e96-1313-6eba-acbc-cbfc235ac433@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[add Mauro to CC]

Am 20.03.2017 um 15:08 schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently, if pservice is null then service is set to NULL and immediately
> afterwards service is dereferenced causing a null pointer dereference. Fix
> this by bailing out early of the function with a null return.
>
> Detected by CoverityScan, CID#1419681 ("Explicit null dereferenced")
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
