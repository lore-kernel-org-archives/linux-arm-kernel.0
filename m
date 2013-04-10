From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 10 Apr 2013 18:11:54 +0400
Subject: [PATCH v3 4/9] rcar-phy: remove EHCI internal buffer setup
In-Reply-To: <20130410082748.GJ7983@arwen.pp.htv.fi>
References: <201304100232.30889.sergei.shtylyov@cogentembedded.com>
 <20130410082748.GJ7983@arwen.pp.htv.fi>
Message-ID: <5165732A.8050901@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 10-04-2013 12:27, Felipe Balbi wrote:

> On Wed, Apr 10, 2013 at 02:32:30AM +0400, Sergei Shtylyov wrote:
>> Now that the EHCI internal  buffer setup is done by the platform code, we  can
>> remove  such code from this driver as it  never  really belonged here.  We also
>> no longer need the 2nd memory region now (2nd EHCI controller is simply missing
>> in e.g. R8A7778 SoC).

>> The patch has been tested on the Marzen and BOCK-W boards.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> Acked-by: Simon Horman <horms+renesas@verge.net.au>

>> ---
>> Changes since version 2:
>> - added a note about testing to the changelog;
>> - added ACKs from Simon Horman and Kuninori Morimoto.

>> Changes since the original posting:
>> - split R8A7779 SoC file change to a separate patch.

>>   drivers/usb/phy/rcar-phy.c |   28 ++++------------------------

> you do realise this won't apply, right ?

    Because of the rename you've done? No, I didn't realize it until you told.
I wasn't watching changes in your tree...

WBR, Sergei
