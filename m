From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 27 Jan 2016 17:55:12 +0100
Subject: [linux-sunxi] Problem with Allwinner H3 clocks
In-Reply-To: <56A8D5E5.30701@gmail.com>
References: <20160127084607.665fb8c38eeb5733ce4232da@free.fr>
 <CAGb2v65FUhNC-d-YT=-2adNHHT6b1JvGoNTFLfBX_xBSnuOsTg@mail.gmail.com>
 <20160127103714.58312b152adb4148bae2f93b@free.fr>
 <56A8D5E5.30701@gmail.com>
Message-ID: <20160127175512.87caf31b5e21a1fec91507f2@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Jan 2016 15:36:21 +0100
Jens Kuske <jenskuske@gmail.com> wrote:

> That sounds strange, 4.5-rc1 is working perfectly fine for me too.
> 
> I doubt the patch you linked is responsible for making it work, it only
> removes the hardcoded output-names. If your DT isn't messed up this
> isn't relevant at all since pll8, the initial reason for this patch, is
> only a dummy clock for now. Are you sure you are using a clean v4.5-rc1
> without any own modifications?

To be sure, I generated a pure 4.5-rc1 kernel. Same result: no UART.
Maybe... one more information: I am using Allwinner's u-boot.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
