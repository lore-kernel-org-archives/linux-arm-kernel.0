From: lhikichi@broadcom.com (Lori Hikichi)
Date: Thu, 2 Apr 2015 15:44:02 -0700
Subject: [alsa-devel] [PATCH 1/2] ASoC: cygnus-audio: adding device tree
 bindings
In-Reply-To: <551A4C37.5090903@metafoo.de>
References: <1427771784-29950-1-git-send-email-sbranden@broadcom.com>
 <1427771784-29950-2-git-send-email-sbranden@broadcom.com>
 <551A4C37.5090903@metafoo.de>
Message-ID: <551DC632.6010400@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 15-03-31 12:26 AM, Lars-Peter Clausen wrote:
> On 03/31/2015 05:16 AM, Scott Branden wrote:
> [...]
>> +- ssp-port-id: The ssp port interface to use
>> +    Valid value are 0, 1, 2, or 3 (for spdif)
>
> How about using 'reg' as the property name here. It is the standard
> property name for identifying or assigning an address to a sub-node.
>
Okay.  Thanks.  I will change.
