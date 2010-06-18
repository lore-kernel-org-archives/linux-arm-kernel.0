From: eric@eukrea.com (=?UTF-8?B?RXJpYyBCw6luYXJk?=)
Date: Fri, 18 Jun 2010 19:50:54 +0200
Subject: [PATCH v2] input/imx_keypad: add PM support
In-Reply-To: <1276882804.3146.14.camel@realization>
References: <1276801147-4103-1-git-send-email-eric@eukrea.com>	
	<1276856186.3146.5.camel@realization> <4C1B84A3.8080300@eukrea.com>
	<1276882804.3146.14.camel@realization>
Message-ID: <4C1BB1FE.9090403@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 18/06/2010 19:40, Alberto Panizzo a ?crit :
> Well.. it is a surprise to me too. I have to look down the documentation
> ad soon I will try on the mx31pdk.

OK, I'm waiting for your feedback on the mx31pdk.

 From my understanding of the documentation, in order to be able to 
wakeup the CPU, the interrupt of a peripheral and its clock should stay 
enabled while going to suspend.

Eric
