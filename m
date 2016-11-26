From: nicolae.rosia.oss@gmail.com (Nicolae Rosia)
Date: Sat, 26 Nov 2016 20:23:35 +0200
Subject: [PATCH] mfd: twl-core: export twl_get_regmap
In-Reply-To: <1479900128.16686.1.camel@mentor.com>
References: <1478950693-13959-1-git-send-email-Nicolae_Rosia@mentor.com>
 <20161118185548.GA23246@dell.home>
 <CAKP5S=3quz8f1H0xnaffJ35L8qSOpSkBEGS8GsNhB5F=v3DoBg@mail.gmail.com>
 <20161121092339.GA32509@dell> <20161121093144.GE23750@n2100.armlinux.org.uk>
 <CAKP5S=28xVyNE=Q7hd2UbtOmT=12ayrcWM5m1OTvk5kGN5pZrw@mail.gmail.com>
 <20161121133755.GF23750@n2100.armlinux.org.uk>
 <20161123111223.GG23750@n2100.armlinux.org.uk>
 <1479900128.16686.1.camel@mentor.com>
Message-ID: <CAKP5S=1a1Qm17JQyx98kSWBK94V3gHSAQv9gBR15AURFJP5SrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2016 at 1:22 PM, Rosia, Nicolae
<Nicolae_Rosia@mentor.com> wrote:
> I'm converting the driver to use mfd_add_devices and
> mfd_remove_devices, the subdrivers will access the parent's private
> data which will remain valid since in the remove method we will be
> calling mfd_remove_devices first.
>
> After removing all global calls to twl-core.c methods, I will also get
> rid of the "only one instance" of twl_priv and the "ready" flag.
>
> Thanks for your input,
> Nicolae

Please ignore this patch, I've sent it in a patch series here [0]

Thanks,
Nicolae

[0] https://www.spinics.net/lists/kernel/msg2392364.html
