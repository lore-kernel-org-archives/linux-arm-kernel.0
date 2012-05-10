From: snijsure@grid-net.com (Subodh Nijsure)
Date: Thu, 10 May 2012 09:08:33 -0700
Subject: i.MX USB Re-Structure
In-Reply-To: <201205101512.27073.marex@denx.de>
References: <20120510060523.GA32703@nchen-desktop>
 <20120510125834.GT27341@pengutronix.de> <201205101512.27073.marex@denx.de>
Message-ID: <4FABE801.7070701@grid-net.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/2012 06:12 AM, Marek Vasut wrote:
> Dear Sascha Hauer,
>
>> On Thu, May 10, 2012 at 02:05:24PM +0800, Peter Chen wrote:
>>> Hi Sascha,
>>>
>>> Recently, Alexander Shishkin has posted new chipidea patchset
>>> (http://www.spinics.net/lists/linux-usb/msg62975.html)
>>> to support USB driver who use chipidea core. In his structure,
>>> all controller related files (like ehci-mxc.c, fsl-udc-core.c, etc)
>>> will be drivers/usb/chipidea, and no related file will be host, gadget
>>> and otg again.
>>>
>>> So, it will be different with marek has posted i.mx28 USB driver,
>>> and also different with your proposal in the past. But I think
>>> you and marek may prefer Alexander's structure, and would like
>>> use it for i.mx in future, correct?
>> I was not aware of this patchset. I only had a short look at it, but
>> yes, it seems to be the way to go, for all SoCs supporting this
>> hardware, be it i.MX, MXS or something else.
> Correct, I can't but agree here.
http://www.spinics.net/lists/linux-usb/msg63064.html

In followup message referenced above Felipe Balbi said he can't put 
above patch in v3.5 pull and has to be deferred till 3.6.

So are we left with roll your own i.MX USB support for 3.5? Is Marek's 
work going to be part of 3.5 pull?

-Subodh
