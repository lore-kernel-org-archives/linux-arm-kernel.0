From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 21 Dec 2016 23:33:22 +0100
Subject: Mainline Patch Enable Can support in sunxi-a20.dtsi
In-Reply-To: <1737278812.179886.1482137303825@email.1und1.de>
References: <1737278812.179886.1482137303825@email.1und1.de>
Message-ID: <20161221223322.phsfhki7alqrkoyb@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christian,

On Mon, Dec 19, 2016 at 09:48:23AM +0100, Christian Waldeck wrote:
> <!DOCTYPE html>
> <html><head>
>     <meta charset="UTF-8">
> </head><body><p>Hello Maxime and Chen-Yu, <br></p><p><br></p><p>I`am currently working with an A20 Board from In-Circuit. <br></p><p>It took us quite some time to fetch all information about enabling the can pins on tha device. <br></p><p>Now we have working solution. <br></p><p><br></p><p>Attached to this email is a patch file which enables can-bus at the sunxi-A20.dtsi file<br></p><p>and the corresponding sun7i-a20-icnova-swac.dts BSP description. <br></p><p><br></p><p>Hopefully you can integrate this piece of configuration<br></p><p>to save time for other users, that are trying to work with the can-bus fram A20 SoC. <br></p><p><br></p><p class="io-ox-signature">Best regards, <br> <br>Christian Waldeck<br> <br>Green Digit GmbH<br>Zeppelinstr. 5<br>82205 Gilching<br><br>fon: +49 (0) 8105 39989-78<br>fax: +49 (0) 8105 39989-77<br><br>http://www.greendigit.de<br><br>Amtsgericht M&#252;nchen, HRB 180693<br>Gesch&#228;ftsf&#252;hrer: Volker Werbus</p></body></html>

Thanks a lot for your patch.

However, it has a number of things that prevent it from being applied as is.

The two majors flaws are that you sent it in HTML format, which
prevents it from being applied. Your patch also lacks a Signed-off-by
tag, which is used to know that you have the legal right to submit the
patch.

You can have more documentation on how to send your first patch here
https://kernelnewbies.org/FirstKernelPatch#head-dc6a8aa0be0d0e8ed9dc03726d0b5a1fb0f65e1f

and in Documentation/SubmittingPatches in the kernel source code.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161221/b203bf31/attachment.sig>
