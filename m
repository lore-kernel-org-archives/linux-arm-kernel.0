From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Mon, 17 Nov 2014 09:43:19 +0100
Subject: [RFC] adp1653: Add device tree bindings for LED controller
In-Reply-To: <20141116075928.GA9763@amd>
References: <20141116075928.GA9763@amd>
Message-ID: <201411170943.20810@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 16 November 2014 08:59:28 Pavel Machek wrote:
> For device tree people: Yes, I know I'll have to create file
> in documentation, but does the binding below look acceptable?
> 
> I'll clean up driver code a bit more, remove the printks.
> Anything else obviously wrong?
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> Thanks,
> 								Pavel
> 
> 

Hello,

I think that this patch is probably not good and specially not 
for n900. adp1653 should be registered throw omap3 isp camera 
subsystem which does not have DT support yet.

See n900 legacy board camera code in file board-rx51-camera.c.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141117/b5bddfdf/attachment.sig>
