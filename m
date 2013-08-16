From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 16 Aug 2013 15:42:57 +0530
Subject: [PATCH] ARM: davinci: nand: specify ecc strength
In-Reply-To: <20130816101013.GY22539@xiaoyu.lan>
References: <1376647647-13681-1-git-send-email-nsekhar@ti.com>
 <20130816101013.GY22539@xiaoyu.lan>
Message-ID: <520DFB29.1080803@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 August 2013 03:40 PM, Holger Hans Peter Freyther wrote:
> On Fri, Aug 16, 2013 at 03:37:27PM +0530, Sekhar Nori wrote:
>> Starting with kernel v3.5, it is mandatory
>> to specify ECC strength when using hardware
>> ECC. Without this, kernel panics with a warning
>> of the sort:
> 
> Ah thanks, it was on my todolist. :)

v3.11 is around the corner, couldn't wait longer.

Thanks,
sekhar
