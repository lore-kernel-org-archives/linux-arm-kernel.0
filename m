From: mugunthanvnm@ti.com (N, Mugunthan V)
Date: Mon, 5 Nov 2012 08:40:34 +0000
Subject: [PATCH net-next 0/2] cpsw: fix resource leak for v3.8
In-Reply-To: <cover.1351930782.git.richardcochran@gmail.com>
References: <cover.1351930782.git.richardcochran@gmail.com>
Message-ID: <EB1619762EAF8B4E97A227FB77B7E0293EA0A1EC@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Richard Cochran [mailto:richardcochran at gmail.com]
> Sent: Saturday, November 03, 2012 1:55 PM
> To: netdev at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org; David Miller; Chemparathy,
> Cyril; N, Mugunthan V; Hiremath, Vaibhav
> Subject: [PATCH net-next 0/2] cpsw: fix resource leak for v3.8
> 
> While looking at the idea of removing all of the register offsets in
> the CPSW's device tree, I noticed that the driver would be leaking IO
> mappings. Although this is, strictly speaking, a bug fix, still it can
> wait to appear in v3.8, since there is no way to use the driver in
> v3.7 (or earlier) anyhow.
> 
> Thanks,
> Richard
> 
> 
> Richard Cochran (2):
>   cpsw: rename register banks to match the reference manual, part 2
>   cpsw: fix leaking IO mappings
> 
>  drivers/net/ethernet/ti/cpsw.c |   39 +++++++++++++++++++-------------
> -------
>  1 files changed, 19 insertions(+), 20 deletions(-)
> 
> --
> 1.7.2.5

The patches look good to me.

Acked-by: Mugunthan V N <mugunthanvnm@ti.com>
