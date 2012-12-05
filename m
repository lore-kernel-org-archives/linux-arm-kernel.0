From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 5 Dec 2012 21:50:42 +0000
Subject: [PATCH v4] backlight: corgi_lcd: Use gpio_set_value_cansleep() to
 avoid WARN_ON
In-Reply-To: <20121205192141.GQ14363@n2100.arm.linux.org.uk>
References: <000201cdd283$baf50160$30df0420$%han@samsung.com>
 <20121205093027.GK14363@n2100.arm.linux.org.uk>
 <CAHod+Gdb_LEnhx5cz9j=q9PyS4L=Yjxs303dHon9i-tgjJRtDA@mail.gmail.com>
 <20121205192141.GQ14363@n2100.arm.linux.org.uk>
Message-ID: <CACxGe6sz_5epOLW47-nbXpBrjc4ZAVaFL3Ge5jt8H9HEbnzpcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 5, 2012 at 7:21 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> As I say above, IMHO it would've been much better to rename these functions
> to be the other way around but David was always very dismissive of any
> comments I had against any code he'd written.

FWIW, I'll gladly take a patch to rename them now if someone does the legwork.

g.
