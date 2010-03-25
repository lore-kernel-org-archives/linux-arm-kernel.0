From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu, 25 Mar 2010 08:28:34 +0200
Subject: [PATCH 0/4] HP iPAQ RX1950 patch series
In-Reply-To: <1269109209-26237-1-git-send-email-anarsoul@gmail.com>
References: <1269109209-26237-1-git-send-email-anarsoul@gmail.com>
Message-ID: <201003250828.56848.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 20 ????? 2010 20:20:05 ????? Vasily Khoruzhick ???????:
> Following patch series add support for iPAQ RX1950 PDA - another
> s3c2442-based machine.
> Almost all drivers for this machine are included in mainline kernel, and
> port only lacks battery, WiFi and sound support, they will be added later.
> 
> Port still uses machine-specific GPIO API, as generic GPIO lacks GPJ
> support and RX1950 actively uses GPJ port. However I do not see any
> benifits in using generic GPIO API in machine support file, as it will not
> be used with CPU different from s3c2442.
> 
> Denis: I hope you'll add your Signed-off at least under first patch.
> 
> I doubt that I can get Signed-off from Victor Chukhantsev, as he doesn't
> work on port for a long time.
> 
> Regards,
> Vasily

Ping :)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100325/51f2f5a3/attachment.sig>
