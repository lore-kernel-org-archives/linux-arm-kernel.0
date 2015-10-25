From: oliver+list@schinagl.nl (Olliver Schinagl)
Date: Sun, 25 Oct 2015 18:32:24 +0100
Subject: [linux-sunxi] [PATCH] i2c: mv64xxx: The n clockdiv factor is
 0 based on sunxi SoCs
In-Reply-To: <20151020155821.GN5379@katana>
References: <1443365828-8956-1-git-send-email-hdegoede@redhat.com>
 <560813CF.4000807@schinagl.nl> <20150929120943.GP7104@lukather>
 <560D80CF.6050500@schinagl.nl> <20151020155821.GN5379@katana>
Message-ID: <562D1228.5030909@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Wolfram,

On 20-10-15 17:58, Wolfram Sang wrote:
>> WIth Hans having figured it out and fixing it, I'll absolutly will take a
>> nother look and check with a scope if it all works out now.
> Have you done this already? /me is always looking for Tested-by: tags :)
And here you have it.

Tested-by: Olliver Schinagl <oliver@schinagl.nl>

I attached the scope traces for a 200.000 Hz i2c0 and a 400.000 Hz i2c1 
(without anything connected to the bus) on a cubieboard2.

Olliver

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 200k.png
Type: image/png
Size: 6542 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151025/5d211822/attachment.png>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 400k.png
Type: image/png
Size: 6200 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151025/5d211822/attachment-0001.png>
