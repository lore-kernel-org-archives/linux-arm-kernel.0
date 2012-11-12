From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 12 Nov 2012 14:02:07 +0900
Subject: [PATCH 1/2] ARM: S3C64XX: Remove duplicated camera clock
In-Reply-To: <509EC5C1.2000901@gmail.com>
References: <509e602f.a766980a.0f91.14f4@mx.google.com>
 <509EC5C1.2000901@gmail.com>
Message-ID: <004901cdc092$dd91a3c0$98b4eb40$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:
> 
> On 11/10/2012 03:07 PM, dron0gus at gmail.com wrote:
> > From: Andrey Gusakov<dron_gus@mail.ru>
> >
> > Camera clock defined two times. One in init_clocks_off array with
> > "cam" name, second in clksrcs array with "camera" name. Leave
> > second definition because clock have divider.
> >
> > Signed-off-by: Andrey Gusakov<dron0gus@gmail.com>
> 
> Reviewed-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>

Applied, thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
