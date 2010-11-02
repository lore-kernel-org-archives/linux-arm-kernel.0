From: gadiyar@ti.com (Gadiyar, Anand)
Date: Tue, 2 Nov 2010 10:10:43 -0400
Subject: [PATCH] omap: tidspbridge: fix build failure on
	MEMBLOCK_REAL_LIMIT
In-Reply-To: <AANLkTi=fGA__ZXHOUz-VH5dhq7jWG7ZuPOzPdrN7xBM+@mail.gmail.com>
References: <1288704660-21683-1-git-send-email-gadiyar@ti.com>
	<AANLkTi=fGA__ZXHOUz-VH5dhq7jWG7ZuPOzPdrN7xBM+@mail.gmail.com>
Message-ID: <AANLkTimagFyRo5a3f7u2TV5a0vyyz5bq1tSfdtcKz0rW@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 2, 2010 at 10:05 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Tue, Nov 2, 2010 at 3:31 PM, Anand Gadiyar <gadiyar@ti.com> wrote:
>> MEMBLOCK_REAL_LIMIT symbol was removed by the commit e63075a3c937
>> (memblock: Introduce default allocation limit and use it to replace
>> explicit ones). This breaks build as below when CONFIG_TIDSPBRIDGE
>> is selected. Fix this.
>
> I would rather apply this:
> http://article.gmane.org/gmane.linux.ports.arm.omap/45076
>

Okay, I hadn't seen that one. Thanks!

- Anand
