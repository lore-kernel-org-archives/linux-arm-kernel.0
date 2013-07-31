From: broonie@kernel.org (Mark Brown)
Date: Wed, 31 Jul 2013 11:36:10 +0100
Subject: New dapm panic on beaver with next-20130730
In-Reply-To: <51F8B045.8030303@metafoo.de>
References: <CAOesGMig6jry1GJLoTnOqxom1KjtBTUtZz-_-SiZLpGTc3VkqA@mail.gmail.com>
 <51F8A933.4080708@metafoo.de>
 <CAOesGMjqyF7zPoGsW6oBRFey7Bc_umnoGob7oQ=_c3n7oevuaQ@mail.gmail.com>
 <51F8B045.8030303@metafoo.de>
Message-ID: <20130731103610.GH9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 08:35:49AM +0200, Lars-Peter Clausen wrote:

> 0x6b6b6b6b is poisoned freed memory. According to the source neither
> the INR Mux nor the INL Mux widget should have any sinks. Can you
> add a couple more printks:

Dan Carpenter sent a patch which is probably the issue - I'm trying to
figure out how to boot my Beaver board so hopefully I can test, it'll be
in -next tomorrow anyway.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130731/62a5d1e0/attachment-0001.sig>
