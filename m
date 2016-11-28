From: patrice.chotard@st.com (Patrice Chotard)
Date: Mon, 28 Nov 2016 13:14:27 +0100
Subject: [GIT PULL] STi defconfig fix for v4.9-rcs
In-Reply-To: <6441620.Ib6HJmGOKY@wuerfel>
References: <0492803d-d136-618d-bf06-51f0001d039b@st.com>
 <6441620.Ib6HJmGOKY@wuerfel>
Message-ID: <94e9f0b7-f793-cc91-9592-4191f13c34c2@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/25/2016 10:40 PM, Arnd Bergmann wrote:
> On Wednesday, November 23, 2016 9:59:14 AM CET Patrice Chotard wrote:
>> STi defconfig fix:
>>
>> Enable HVA (Hardware Video Accelerator) video encoder
>> driver for STMicroelectronics SoC.
> 

Hi Arnd

> Defconfig changes like this don't seem particularly urgent. Unless
> there is a good reason, I'd suggest putting this into v4.10 instead.

You are right, it's not a urgent update for STi.
I will send a pull request dedicated for v4.10.

Thanks

Patrice

> 
> 	Arnd
> 
