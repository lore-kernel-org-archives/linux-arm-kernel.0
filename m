From: mail@pawelmoll.com (Pawel Moll)
Date: Tue, 21 Sep 2010 14:23:35 +0100
Subject: [PATCH v2 2/3] [ARM] tegra: add PCI Express support
In-Reply-To: <201009211430.00325.arnd@arndb.de>
References: <cover.1285070872.git.mike@compulab.co.il>
	<bb6c83c24e809d944beb2950c60cd89257baa1ea.1285070872.git.mike@compulab.co.il>
	<201009211430.00325.arnd@arndb.de>
Message-ID: <cfbe99c95d8d0ed7b5e139afc44ddaac@cox.rootnode.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>  #define __io(a)         __io(a)
>>  #define __mem_pci(a)    (a)
> 
> I wonder what the #else path is for. If you don't have PCI, who would
> call __io? And wouldn't that result in a NULL pointer dereference?

If I remember correctly the legacy IDE (ATA) code is scanning "well
known" IO port numbers...

Cheers!

PAwe?
