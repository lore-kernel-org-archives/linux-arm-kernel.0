From: hemantp@ti.com (Pedanekar, Hemant)
Date: Thu, 4 Aug 2011 22:58:22 +0530
Subject: [PATCH 3/4] TI816X: clock: Add clockdomains and powerdomains data
In-Reply-To: <alpine.DEB.2.00.1107160154080.25013@utopia.booyaka.com>
References: <1301070022-8405-1-git-send-email-hemantp@ti.com>
	<alpine.DEB.2.00.1107160154080.25013@utopia.booyaka.com>
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03ABA7E9FB@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Walmsley wrote on Saturday, July 16, 2011 1:25 PM:

> On Fri, 25 Mar 2011, Hemant Pedanekar wrote:
> 
>> This patch adds data for various clock domains and power domains in TI816X.
>> 
>> Note that at present this is not exhaustive and need to add missing
>> domains. 
>> 
>> Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
>> ---
>>  arch/arm/mach-omap2/clockdomains816x.h |  167
> ++++++++++++++++++++++++++++++++
>>  arch/arm/mach-omap2/powerdomains816x.h |   74 ++++++++++++++
>>  2 files changed, 241 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/arm/mach-omap2/clockdomains816x.h
>>  create mode 100644 arch/arm/mach-omap2/powerdomains816x.h
> 
> Static data shouldn't be declared in .h files; it should be declared in
> *domains81*_data.c files, as is the practice with the rest of the
> powerdomains/clockdomains data here.
> 
Will take care of this in next version.

Thanks.

   Hemant
