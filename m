From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 29 Aug 2016 21:29:35 +0200
Subject: input: touchscreen: silead_gsl1680: Document firmware-name,
 fix implementation
Message-ID: <20160829192937.32129-1-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

As discussed here is a patch to update the gsl1680 driver binding
doc to document the usage of firmware-name for specifying which
firmware to load.

Since the driver as merged in 4.8-rc1 uses touchscreen-fw-name,
this patch also updates the driver and moves the addition of the
"silead/" prefix to the driver instead of having to specify
the prefix in the dt.

I've also added a second patch to also prefix the default /
fallback firmware-names with "silead/".

Dmitry, since no kernel has been released with the old firmware names
yet, it would be good if we can get both of these merged as a fix
to 4.8, so that no one can end up depending on the old behavior.

Thanks & Regards,

Hans
