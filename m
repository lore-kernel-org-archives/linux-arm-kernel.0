From: zonque@gmail.com (Daniel Mack)
Date: Tue, 15 May 2012 16:09:04 +0200
Subject: Compile err with raumfeld_defconfig
In-Reply-To: <1337066754-20520-1-git-send-email-jgq516@gmail.com>
References: <1337066754-20520-1-git-send-email-jgq516@gmail.com>
Message-ID: <4FB26380.9050502@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.05.2012 09:25, jgq516 at gmail.com wrote:
> Hi,
> 
> Does somebody notice this compile err with raumfeld_defconfig as follows?
> 
> drivers/input/touchscreen/eeti_ts.c: In function 'eeti_ts_irq_active':
> drivers/input/touchscreen/eeti_ts.c:65:2: error: implicit declaration of function 'irq_to_gpio'

Yes, this is being worked on. Thanks for noticing, though :)


Daniel
