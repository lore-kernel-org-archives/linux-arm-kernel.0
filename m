From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 30 May 2013 21:28:05 +0400
Subject: [RFC PATCH 1/2] USB: OHCI: make ohci-platform a separate driver
In-Reply-To: <Pine.LNX.4.44L0.1305301321340.1137-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1305301321340.1137-100000@iolanthe.rowland.org>
Message-ID: <51A78C25.1050500@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 05/30/2013 09:23 PM, Alan Stern wrote:

>
>> This patch splits the ohci-platform code from ohci-hcd out
>> into its own separate driver module.This work is part of enabling
>> multi-platform kernels on ARM.
> Okay, except...
>
>> +static const struct ohci_driver_overrides platform_overrides = {
>> +	.product_desc =	"Generic Platform EHCI controller",

     Maybe "OHCI"? :-)

> Alan Stern

WBR, Sergei
