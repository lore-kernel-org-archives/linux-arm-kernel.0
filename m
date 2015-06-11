From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Thu, 11 Jun 2015 11:26:20 +0200
Subject: [PATCH 0/1] i2c: at91: fix code checker warnings
In-Reply-To: <cover.1434013494.git.cyrille.pitchen@atmel.com>
References: <cover.1434013494.git.cyrille.pitchen@atmel.com>
Message-ID: <5579543C.6040108@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

this patch was made after applying the previous series
"[PATCH v6 0/6] i2c: at91: add support to FIFOs and alternative command",
which was already accepted.

Best Regards,

Cyrille

Le 11/06/2015 11:16, Cyrille Pitchen a ?crit :
> ChangeLog
> 
> v1:
> This patch fixes somes code checker warnings reported by Wolfram Sang:
> 
> drivers/i2c/busses/i2c-at91.c:213: style: Checking if unsigned variable 'buf_len' is less than zero.
> drivers/i2c/busses/i2c-at91.c:254: style: Checking if unsigned variable 'buf_len' is less than zero.
> drivers/i2c/busses/i2c-at91.c:293: style: Checking if unsigned variable 'buf_len' is less than zero.
> 
> Thanks for reporting!
> 
> Cyrille Pitchen (1):
>   i2c: at91: fix code checker warnings
> 
>  drivers/i2c/busses/i2c-at91.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
