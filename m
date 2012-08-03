From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Fri, 3 Aug 2012 23:08:22 +0300
Subject: [PATCH v3] printk: add option to print cpu id
In-Reply-To: <CAFm5wm3ScpUU5wa=ei3TY0zjU4kVbOgJMmE5_QDpwy7B-TJa+A@mail.gmail.com>
References: <1344013004-32211-1-git-send-email-vikram.pandita@ti.com>
 <m2628z6euk.fsf@firstfloor.org>
 <CAFm5wm3ScpUU5wa=ei3TY0zjU4kVbOgJMmE5_QDpwy7B-TJa+A@mail.gmail.com>
Message-ID: <20120803200822.GC731@harshnoise.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Aug 03, 2012 at 11:25:37AM -0700, Pandita, Vikram wrote:
> > And really: Wasting 1/3 of the 80 character line is too much.
> 
> You _WASTE_ 4 chars only if you are interested in this info by
> enabling: CONFIG_PRINTK_CPUID

I guess you waste 4 + 3 chars? You could optimize the length by checking
CONFIG_NR_CPUS?

A.
