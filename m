From: saeed.bishara@gmail.com (saeed bishara)
Date: Wed, 4 May 2011 12:50:08 +0300
Subject: [PATCH v2] kirkwood: add dir-665 support
In-Reply-To: <20110504081627.GY19806@kw.sim.vm.gnt>
References: <1303922086-10531-1-git-send-email-camhirundo@gmail.com>
	<1304496346-13557-1-git-send-email-camhirundo@gmail.com>
	<20110504081627.GY19806@kw.sim.vm.gnt>
Message-ID: <BANLkTim6J-wpp+=xsaaxwjmr4XLe-Aa8KA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 4, 2011 at 11:16 AM, Simon Guinot <simon@sequanux.org> wrote:
> Hi Hirundo,
>
> On Wed, May 04, 2011 at 04:05:46PM +0800, Hirundo Cam wrote:
>> This patch is a hack to dir-665 by referencing mv88f6281gtw_ge board.
>> LEDs, GPIO, Buttons remains unknown.
Hirundo,
   if this board is very similar to mv88f6281gtw_ge, you should use
the same board setup file. it will be great if you specify the
differences between the two boards.
   please have a look at sheevaplug-setup.c to see how multiple boards
supported in same setup file.
saeed
