From: arun.parameswaran@broadcom.com (Arun Parameswaran)
Date: Mon, 30 Jul 2018 09:47:29 -0700
Subject: [PATCH v2 6/7] net: phy: Add support to configure clock in
 Broadcom iProc mdio mux
In-Reply-To: <20180728000303.GA23816@lunn.ch>
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532726613-6483-7-git-send-email-arun.parameswaran@broadcom.com>
 <20180728000303.GA23816@lunn.ch>
Message-ID: <b7b62b2f-2936-c8d0-3443-66d00713db20@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew

On 18-07-27 05:03 PM, Andrew Lunn wrote:
>>  static void mdio_mux_iproc_config(struct iproc_mdiomux_desc *md)
>>  {
>>  	u32 val;
>> +	u32 divisor;
> 
> Hi Arun
> 
> Reverse Christmas tree please.
> 
> 	Andrew
> 
Ok, will send out an updated patch.

Thanks
Arun
