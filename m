From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 28 Nov 2013 21:11:48 +0400
Subject: [PATCH 03/04] ARM: shmobile: Genmai I2C-over-GPIO support
In-Reply-To: <20131127110413.GA2603@katana>
References: <20131127082736.20015.21303.sendpatchset@w520>
 <20131127082805.20015.82680.sendpatchset@w520> <20131127110413.GA2603@katana>
Message-ID: <52977954.20006@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 27-11-2013 15:04, Wolfram Sang wrote:

>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		eeprom: 24c128 at 50 {
>> +			compatible = "at,24c128";

> Minor nit: Should be a vendor name, not the name of the driver

    Moreover, the node should be named generically, like "flash at 50", not 
"24c128 at 50".

WBR, Sergei
