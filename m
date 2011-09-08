From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 08 Sep 2011 14:55:48 +0200
Subject: Tasks schedule/migration issue with CPU hotplug?
In-Reply-To: <CAOwKts8pXt6spknNfBV-wy4_KoSp-JaZsdbzOxxWTqu=f6X3Bg@mail.gmail.com>
References: <CAOwKts_WTDBLkz9=0MBhs6wzc67XD_bYgGMiZ-JUM+8O7gP_fw@mail.gmail.com>
	<CAOwKts8pXt6spknNfBV-wy4_KoSp-JaZsdbzOxxWTqu=f6X3Bg@mail.gmail.com>
Message-ID: <1315486548.20256.4.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-09-08 at 14:47 +0800, TAO HU wrote:
> > We seems got a schedule/migration issue in a OMAP4430 dual-core system.
> > The kernel base is 2.6.35.7 and we're using CFS.

step 1, try with a kernel that isn't quite as fossilized 
	(3.0 or even better 3.1-rc)
step 2, if no luck, report that
step 3, when sending email, 
     3a, don't wrap machine output
     3b, include .config like things
