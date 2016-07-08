From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  8 Jul 2016 18:05:41 +0200
Subject: [PATCH 00/15] ARM: dts: sunxi: Add reference-design-tablet.dtsi files
 + 2 new tablets
Message-ID: <1467993956-19535-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime, Chen-Yu,

Here is a series based on Chen-Yu's suggestion to add a
reference-design-tablet.dtsi file. This works out quite
nicely, resulting in much simpler tablet .dts files, as
well as enabling a bunch of extra features on some tablets,
showing that having to add the same dts bits over and over
again for all model tablets is not a good idea.

This also includes a v2 submission of the new tablet dts
files which sparked the reference-design-tablet.dtsi
discussion.

Regards,

Hans
