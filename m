From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Fri, 7 Oct 2011 15:45:48 +0200
Subject: [PATCH 1/4] mmc: mmci: Bugfix in pio read for small packets
In-Reply-To: <20111001160937.GF11710@n2100.arm.linux.org.uk>
References: <1317109568-17905-1-git-send-email-ulf.hansson@stericsson.com>
	<20111001160937.GF11710@n2100.arm.linux.org.uk>
Message-ID: <4E8F028C.10102@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Tue, Sep 27, 2011 at 09:46:08AM +0200, Ulf Hansson wrote:
>> From: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
>>
>> Corrects a bug in pio read when reading packets < 4 bytes. These
>> small packets are only relevant for SDIO transfers.
> 
> Does this even work?  From the MMCI spec, I see no way for the MMCI
> peripheral to know the size of the read/write on the APB bus.
> 

Hi Russel,

My feeling is that since discussing this patch, the rest of the patches 
in this serie and are kind of "put on hold". The reason for keeping them 
together is more of functional purpose. I hope you can have a look at 
them anyway, they shall be possible to apply without this one.

If you prefer we can split up this patchserie...

BR
Ulf Hansson
