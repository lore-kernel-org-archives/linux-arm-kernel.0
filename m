From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Mon, 24 Nov 2014 19:58:34 +0100
Subject: v3.18-rc1: n900 battery discharged down to 2.97V
In-Reply-To: <20141124183130.GA2927@amd>
References: <20141124183130.GA2927@amd>
Message-ID: <201411241958.34578@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 November 2014 19:31:30 Pavel Machek wrote:
> Hi!
> 
> I left the machine on usb-networking for extended period of
> time. Unfortunately, Xfce screensaver kept screen busy, and
> kernel failed to kill the machine.
> 
> At the end, hardware protections worked (I guess), but result
> is battery discharged down to 2.97V.
> 
> Best regards,
> 									Pavel

So you need some program which will monitor battery status and 
when battery status is empty it should turn of device.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141124/1f5f1547/attachment-0001.sig>
