From: klightspeed@killerwolves.net (Ben Peddell)
Date: Tue, 18 Feb 2014 10:07:04 +1000
Subject: [PATCH v4 2/4] DT: Vendor prefixes: Add ricoh, ssi and synology
In-Reply-To: <20140217223413.GB31116@joshc.qualcomm.com>
References: <1392673537-17308-1-git-send-email-klightspeed@killerwolves.net>
 <1392673537-17308-3-git-send-email-klightspeed@killerwolves.net>
 <20140217223413.GB31116@joshc.qualcomm.com>
Message-ID: <5302A428.3060708@killerwolves.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/02/2014 8:34 AM, Josh Cartwright wrote:
> On Tue, Feb 18, 2014 at 07:45:35AM +1000, klightspeed at killerwolves.net wrote:
>> From: Andrew Lunn <andrew@lunn.ch>
>>
>> The following patches make use of vendor names ricoh, ssi and
>> synology.  Add them to the vendor prefix list.
>>
>> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
>> Acked-by: Jason Cooper <jason@lakedaemon.net>
>> ---
>> v2:
>> Use stock ticker for Ricoh as vendor name
>> s/Richoh/Ricoh/
>> ---
>>  Documentation/devicetree/bindings/vendor-prefixes.txt | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> index 40ce2df..8427681 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> @@ -72,6 +72,7 @@ ralink	Mediatek/Ralink Technology Corp.
>>  ramtron	Ramtron International
>>  realtek Realtek Semiconductor Corp.
>>  renesas	Renesas Electronics Corporation
>> +ricoy	Ricoh Co. Ltd.
>>  rockchip	Fuzhou Rockchip Electronics Co., Ltd
>>  samsung	Samsung Semiconductor
>>  sbs	Smart Battery System
>> @@ -79,11 +80,13 @@ schindler	Schindler
>>  sil	Silicon Image
>>  silabs	Silicon Laboratories
>>  simtek
>> +sii	Seiko Instruments, Inc.
>>  sirf	SiRF Technology, Inc.
>>  snps 	Synopsys, Inc.
>>  st	STMicroelectronics
>>  ste	ST-Ericsson
>>  stericsson	ST-Ericsson
>> +synology	Synology, Inc.
> 
> Oh, great!  Looks like this one is added (see my comment on patch 1).
> I'm wondering if 'qnap' should be added as well.

Do we want to use "qnap" or their ticker "qnapsz"?
