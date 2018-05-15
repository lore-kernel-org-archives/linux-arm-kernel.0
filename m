From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 15 May 2018 10:34:18 +0100
Subject: [PATCH v6 04/11] firmware: xilinx: Add query data API
In-Reply-To: <SN1PR02MB37587E3AB2718E1DB510E35AB89C0@SN1PR02MB3758.namprd02.prod.outlook.com>
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
 <1523389127-14243-5-git-send-email-jollys@xilinx.com>
 <85f8f8c5-a177-dad8-e095-a9dd1c513e8d@arm.com>
 <SN1PR02MB37587E3AB2718E1DB510E35AB89C0@SN1PR02MB3758.namprd02.prod.outlook.com>
Message-ID: <ab9632f5-882d-462d-d830-0316cad56baf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 14/05/18 20:16, Jolly Shah wrote:
> HI Sudeep,
> 

[...]

>> 
>> Can you give more insight into this ? How will be this used ? How
>> this aligns with data we get from DT ? I am just trying to
>> understand how is this information split between this API and DT
>> for example.
>> 
> 
> This API is used to get clock information from firmware and register
> clocks accordingly in driver. In our case, firmware maintains
> database of all clocks available on chip. DT will provide information
> for off chip reference clocks only. This is to avoid duplication of
> clocks data in DT and firmware both as firmware anyways need clock
> data to manage them.
> 

I wanted to understand the difference with example. What kind of
information you get from DT and what you get from firmware ?

-- 
Regards,
Sudeep
