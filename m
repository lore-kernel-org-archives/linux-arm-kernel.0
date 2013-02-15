From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 15 Feb 2013 18:26:28 +0530
Subject: [RFC/RFT PATCH 1/2] ARM: OMAP2+: hwmod-data: UART IP needs
 software control of sidle modes
In-Reply-To: <20130215125055.GA16558@arwen.pp.htv.fi>
References: <1360930106-32005-1-git-send-email-santosh.shilimkar@ti.com>
 <20130215125055.GA16558@arwen.pp.htv.fi>
Message-ID: <511E307C.8010600@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 February 2013 06:20 PM, Felipe Balbi wrote:
> On Fri, Feb 15, 2013 at 05:38:26PM +0530, Santosh Shilimkar wrote:
>> OMAP UART IP needs manual idle modes based on state of the
>> IP. Currently this is handled by the driver with function pointers
>> implemented in platform code.
>>
>> This however breaks in case of device tree because of missing
>> idle handling. With the provided flags, idle mode handling is transparently
>> handled by runtime time pm code.
>
> this last sentence can be improved a bit.
>
Indeed.

Regards,
Santosh
