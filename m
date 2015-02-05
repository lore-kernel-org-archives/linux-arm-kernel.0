From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 5 Feb 2015 20:40:18 +0100
Subject: [PATCH] at91: i2c-at91: improve time-out handling
In-Reply-To: <CAJjB1qJSBzwviN7Ey+9AHmiEy1PcTKOnPOWVc8xFCZmfkW-BRw@mail.gmail.com>
References: <54A58BA5.3080003@interlog.com>
 <20150107103113.GA30897@ldesroches-Latitude-E6320>
 <20150113152752.GK7660@katana> <54C41FD0.2010607@interlog.com>
 <CAJjB1qJSBzwviN7Ey+9AHmiEy1PcTKOnPOWVc8xFCZmfkW-BRw@mail.gmail.com>
Message-ID: <20150205194017.GI15307@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 26, 2015 at 12:19:23PM -0500, Mark Roszko wrote:
> You can check if ret == -ETIMEDOUT in the error path instead of
> allocating another variable.
> 
> You also generated the patch with your /arch/arm/boot/dts/Makefile changes.

True. Someone cares to respin this patch?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150205/8e88ba10/attachment.sig>
