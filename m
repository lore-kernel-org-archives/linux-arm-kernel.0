From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Thu, 12 Jan 2017 19:34:19 +0100
Subject: Nokia N900: mixers changed between 4.6 and 4.10,
 no longer can use in-call speaker
In-Reply-To: <20170112181826.GA28290@amd>
References: <20170112181826.GA28290@amd>
Message-ID: <201701121934.19810@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 January 2017 19:18:26 Pavel Machek wrote:
> Hi!
> 
> In v4.10 (and probably v4.9, too) I can no longer use the in-call
> speaker. I can no longer use the wired headset, either.
> 
> v4.4 (and probably v4.6) works ok.
> 
> Any ideas? Does wired headset / in-call speaker work for you?
> 
> "Mono" and "Mono DAC" options are still there.. but something else
> changed, as alsamixer now shows way many more options (meaning they
> are shorter?) and I get complains from alsactl:
> 
> alsactl: set_control:1328: failed to obtain info for control #49 (No
> such file or directory)
> ...
> alsactl: set_control:1328: failed to obtain info for control #229 (No
> such file or directory)
> 
> 
> 
> 								Pavel

Looks like there are not so much commits related to 
sound/soc/omap/rx51.c Maybe it can be one of these twos?

cb7e62256e99d285e415cf75db67558f0f8bb107
6d2de5ab4328718302c54b20222c6b1a574c3fce

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170112/2c86eae0/attachment.sig>
