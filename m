From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 16 Mar 2013 01:08:31 +0300
Subject: [RFC] USB: EHCI: hot-fix OMAP and Orion multiplatform config
In-Reply-To: <201303152015.31292.arnd@arndb.de>
References: <Pine.LNX.4.44L0.1303151516170.1414-100000@iolanthe.rowland.org>
 <201303152015.31292.arnd@arndb.de>
Message-ID: <51439BDF.3050300@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 03/15/2013 11:15 PM, Arnd Bergmann wrote:

> On Friday 15 March 2013, Alan Stern wrote:
>> I just got an automated message from Greg:
>>
>> --------------------------------------------------------------------------
>> This is a note to let you know that I've just added the patch titled
>>
>>      USB: EHCI: split ehci-omap out to a separate driver
>>
>> to my usb git tree which can be found at
>>      git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
>> in the usb-next branch.
>> --------------------------------------------------------------------------
>>
>> Unless something is changed, this patch won't get into 3.9-final.
>> Do you want Greg to move it to his usb-linus branch?
> I don't care much which way we do it, but I'd certainly like to
> see one of these two solutions for the bug:
>
> a) Apply Roger's patch for 3.9, and add my "USB: EHCI: DT support
>     for generic bus glue" patch on top after it has been tested

    Arnd, sorry, where can I find this patch? Archive search doesn't 
turn up anything...

WBR, Sergei
