From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Sat, 6 Dec 2014 18:40:16 +0100
Subject: N900: fixing MMC at boot
In-Reply-To: <20141206173526.GA7964@amd>
References: <20141206173526.GA7964@amd>
Message-ID: <201412061840.16157@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 06 December 2014 18:35:27 Pavel Machek wrote:
> Hi!
> 
> For a long time, MMC was not working during boot... (making
> the box unusable without nfsroot). It seems problem is in the
> regulators, because with diff below, I was able to mount root
> on SD card for a first time ... in a long time.
> 

Hi, do you mean external SD card or internal eMMC (MyDocs)?

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141206/d3ed0f87/attachment.sig>
