From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 27 Feb 2013 10:22:00 +0100
Subject: [PATCH 1/2] USB mxs-phy: Register phy with framework
In-Reply-To: <20130227081017.GF8016@arwen.pp.htv.fi>
References: <1359631937-26646-1-git-send-email-s.hauer@pengutronix.de>
 <1359631937-26646-2-git-send-email-s.hauer@pengutronix.de>
 <20130214103729.GC15537@arwen.pp.htv.fi>
 <20130214162337.GU1906@pengutronix.de>
 <20130214180011.GC25891@arwen.pp.htv.fi>
 <20130214184354.GX1906@pengutronix.de>
 <20130227081017.GF8016@arwen.pp.htv.fi>
Message-ID: <512DD038.3040301@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/27/2013 09:10 AM, Felipe Balbi wrote:
> On Thu, Feb 14, 2013 at 07:43:54PM +0100, Sascha Hauer wrote:
>> On Thu, Feb 14, 2013 at 08:00:11PM +0200, Felipe Balbi wrote:
>>> Hi,
>>>
>>> On Thu, Feb 14, 2013 at 05:23:37PM +0100, Sascha Hauer wrote:
>>>> On Thu, Feb 14, 2013 at 12:37:29PM +0200, Felipe Balbi wrote:
>>>>> Hi,
>>>>>
>>>>> On Thu, Jan 31, 2013 at 12:32:16PM +0100, Sascha Hauer wrote:
>>>>>> We now have usb_add_phy_dev(), so use it to register with the framework
>>>>>> to be able to find the phy from the USB driver.
>>>>>>
>>>>>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>>>>>
>>>>> Sascha, are you taking this through your tree or you want me to queue it
>>>>> up ?
>>>>
>>>> I would prefer if either you could take it or Alexander Shishkin along
>>>> with the other patches in:
>>>>
>>>> [PATCH v4] USB: add devicetree helpers for determining dr_mode and phy_type
>>>>
>>>> Could you have a look at them? Alexander is asking for an ack for 1/9,
>>>> 2/9, 3/9, 8/9. I just realized you are not on Cc for these. I could
>>>> bounce you the patches in case you don't have them in your mailbox.
>>>
>>> Ok, I'll look at them, no need to bounce. You _do_ realize, however,
>>> that Greg has already closed all his trees for v3.9, right ? So anything
>>> from now on will be queued for v3.10.
>>
>> I'm fine with that. I'm just a bit insistent because the chipidea patches are
>> floating around for half a year now. Once I have the warm feeling that
>> the patches are handled I have time ;)
> 
> I'm getting ready to queue patches but, when looking at this thread, it
> seems like another version should've been sent. I'll skip this and look
> at the other chipidea threads,

I'm currently rebasing Saschas patches to Greg's usb-net.

Marc

---
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130227/2b8b8b74/attachment.sig>
