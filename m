From: ynvich@gmail.com (Sergei Ianovich)
Date: Tue, 28 Jan 2014 18:20:34 +0400
Subject: [PATCH 01/11] resolve PXA<->8250 serial device address conflict
In-Reply-To: <20140128141437.GB8713@xo-6d-61-c0.localdomain>
References: <1385879185-22455-1-git-send-email-ynvich@gmail.com>
 <1385879185-22455-2-git-send-email-ynvich@gmail.com>
 <20140128141437.GB8713@xo-6d-61-c0.localdomain>
Message-ID: <1390918834.22403.16.camel@host5.omatika.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-01-28 at 15:14 +0100, Pavel Machek wrote:
> Yes, please. I was hitting the same issue with Sharp Zaurus and bluetooth
> CF card... Bluetooth card had 8250 inside...

A better implementation is posted as v3 of the patch.

http://linux-kernel.2935.n7.nabble.com/PATCH-00-11-ARM-support-for-ICP-DAS-LP-8x4x-tp761919p773485.html

It would be great if you could test that patch add post back the
results.
