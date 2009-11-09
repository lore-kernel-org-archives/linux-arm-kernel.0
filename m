From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 09 Nov 2009 14:48:22 +0100
Subject: Experimental patch is missing AT91 board
In-Reply-To: <f64919da0911090047y5d17848fx39cf96227f197000@mail.gmail.com>
References: <f64919da0911090047y5d17848fx39cf96227f197000@mail.gmail.com>
Message-ID: <4AF81DA6.8010702@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

suse auto :
> 
> Hi,
> 
> I am trying to compile / build a linux kernel for AT91SAM9263EK board. I
> downloaded the Linux 2.6.30 from kernel.org <http://kernel.org/>. Then
> while I tried to download
> patches for the AT91 board, I could download the maintainer patch list (
> 2.6.30-at91.patch.gz<http://maxim.org.za/AT91RM9200/2.6/2.6.30-at91.patch.gz>)
> from
> http://maxim.org.za/AT91RM9200/2.6/2.6.30-at91.patch.gz , but i could not
> get the experimental patch
> (2.6.30-at91-exp.tar.gz<ftp://www.at91.com/pub/linux/2.6.30-at91/2.6.30-at91-exp.tar.gz>)
> from
> ftp://www.at91.com/pub/linux/2.6.30-at91/2.6.30-at91-exp.tar.gz.
> 
> can somebody tell me if this experimental patch is available else where?
> can you give any other suggestion for linux kernel for AT91 board?

Server did not have good configuration. It is fixed now.

Note however that you will have to apply this patch series with
following command:

for p in 2.6.30-at91-exp/*; do patch -p1 < $p; done

instead of the single file patching technique.

Best regards,
-- 
Nicolas Ferre
