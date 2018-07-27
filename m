From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 27 Jul 2018 15:22:33 +0530
Subject: [PATCH v4 08/18] net: davinci_emac: potentially get the MAC
 address from MTD
In-Reply-To: <efd9388f-c378-4723-602d-1209c8bae7d3@ti.com>
References: <20180629094039.7543-1-brgl@bgdev.pl>
 <20180629094039.7543-9-brgl@bgdev.pl>
 <03b77e24-9ab9-fa01-2387-9de0408a9942@gmail.com>
 <20180704070919.GA14051@lenoch>
 <CAMRc=McOYG9=naT2=4c4hnhJwxcqBCATEZOGXXv9u9zuvXyDXw@mail.gmail.com>
 <c0ffc590-8064-3b02-9b5c-fcc24628d390@ti.com>
 <CAMRc=McO8H9Aw8a7h318a=hJjKBOgeC+9_hreBnOY3Tc3Fh7sg@mail.gmail.com>
 <d7f03763-982f-5e3e-d0ad-54e024b10f97@ti.com>
 <a70aebb0-408c-c61f-897a-227114888585@linaro.org>
 <efd9388f-c378-4723-602d-1209c8bae7d3@ti.com>
Message-ID: <e98a0d1b-a587-cf6e-9b95-726701241331@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 July 2018 10:34 AM, Sekhar Nori wrote:

> There is a lot of follow-up traffic on how exactly to develop the needed
> interfaces for reading mac address in mtd and/or network subsystem.
> 
> But, I don't think any of that negates the need for nvmem lookups that
> work for non-device-tree and populating the lookups in mach-davinci
> board code.
> 
> I am going to send patches 1-7 to ARM-SoC soon, so please do say if
> there is any disagreement on this.

I owed a response on this. After thinking over some and discussing with
Bartosz as well, I decided not to merge any patches from  this series.
Its better to merge anything after the actual path we are talking is
fully clear.

Thanks,
Sekhar
