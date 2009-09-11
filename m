From: p.osciak@samsung.com (Pawel Osciak)
Date: Fri, 11 Sep 2009 20:04:45 +0200
Subject: [PATCH 0/7] [ARM] s3c-fb: Various s3c-fb updates.
Message-ID: <E4D3F24EA6C9E54F817833EAE0D912AC0771185D57@bssrvexch01.BS.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
this patch series adds some new features to the driver, as well as fixes to the existing register handling (patch 4/7).
It is rebased onto my previous patchset ([PATCH v2 0/3] v2: s3c-fb panning and vsync support).

The series contains:

[PATCH 1/7] [ARM] s3c-fb: Added colorkey support
[PATCH 2/7] [ARM] s3c-fb: Added window source selection.
[PATCH 3/7] [ARM] s3c-fb: Added support for alpha blending.
[PATCH 4/7] [ARM] s3c-fb: Corrected and added new VIDOSD register macros.
[PATCH 5/7] [ARM] s3c-fb: Added missing window enabled state updates.
[PATCH 6/7] [ARM] s3c-fb: Added debugfs interface.
[PATCH 7/7] [ARM] s3c-fb: Added color key blending.

Best regards
--
Pawel Osciak
Linux Platform Group
Samsung Poland R&D Center
