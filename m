From: wookey@wookware.org (Wookey)
Date: Wed, 10 May 2017 15:52:05 +0100
Subject: [PATCH v5 0/5] Add ARM Mali Midgard device tree bindings and gpu
 node for rk3288
In-Reply-To: <425541fd-e648-1db7-9c31-13d2d4f094b4@collabora.com>
References: <cover.1493804968.git.guillaume.tucker@collabora.com>
 <12996903.t3AZceNVOh@diego>
 <b63475e9-21f6-5995-90b6-e0eeae8144ab@rock-chips.com>
 <b43fc703-3c39-58e9-6006-1aa7f9d0cea6@collabora.com>
 <ddec5773-43ef-a4c3-2280-8f0c5b1f1c4d@rock-chips.com>
 <425541fd-e648-1db7-9c31-13d2d4f094b4@collabora.com>
Message-ID: <20170510145205.GJ27127@mail.wookware.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-05-10 11:10 +0100, Guillaume Tucker wrote:
> 
> On a side note, it would be fantastic to get all this available
> in Debian packages :)

There are prototype debian packages here:
https://git.linaro.org/people/wookey/mali/mali-dkms.git/
https://git.linaro.org/people/wookey/mali/mali-drivers.git/

Which I'm very happy to get feedback on if people try them with
guillaume's DTB patches.

Quite hacky at the moment, but I want to prove they work at all before
tarting up the packaging.

Wookey
-- 
Principal hats:  Linaro, Debian, Wookware, ARM
http://wookware.org/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170510/87d60ded/attachment.sig>
