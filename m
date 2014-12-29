From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Mon, 29 Dec 2014 10:43:50 -0800
Subject: [PATCH] ARM: onfig: multi_v7: Update it for Keystone defconfig
In-Reply-To: <20141229172034.GK29379@saruman>
References: <1419873207-3630-1-git-send-email-santosh.shilimkar@oracle.com>
 <20141229172034.GK29379@saruman>
Message-ID: <54A1A0E6.9000504@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/29/2014 9:20 AM, Felipe Balbi wrote:
> Hi,
>
> subject typo: s/onfig/config/
>
> On Mon, Dec 29, 2014 at 09:13:27AM -0800, Santosh Shilimkar wrote:
>> @@ -346,9 +354,13 @@ CONFIG_USB_OHCI_HCD=y
>>   CONFIG_USB_OHCI_HCD_STI=y
>>   CONFIG_USB_OHCI_HCD_PLATFORM=y
>>   CONFIG_USB_STORAGE=y
>> +CONFIG_USB_DWC3=y
>> +CONFIG_USB_DWC3_DEBUG=y
>> +CONFIG_USB_DWC3_VERBOSE=y
>
> you don't really need DEBUG or VERBOSE to be enabled always.
>
Right. Will fix that
