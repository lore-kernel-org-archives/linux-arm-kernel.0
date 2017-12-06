From: sky@genki.is (Genki Sky)
Date: Tue, 05 Dec 2017 19:09:53 -0500
Subject: [PATCH v3 0/3] staging: vc04_services: Fix small style issues
Message-ID: <cover.1512518762.git.sky@genki.is>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is v3 of a patch series to fix some checkpatch.pl warnings in
drivers/staging/vc04_services/bcm2835-camera/*

Changes from v2 [2]:
- Provide more detailed description in commit messages

Changes from v1 [1]:
- Split single patch into multiple patches
- Remove reference to eudyptula in commit message

[1]: https://lkml.kernel.org/r/30cc7b48def470f1bec8d8d255044f4f220531ee.1512368114.git.sky at genki.is
[2]: https://lkml.kernel.org/r/cover.1512441073.git.sky at genki.is

[ aside: this is for task-10 of http://eudyptula-challenge.org/ ]

Genki Sky (3):
  staging: vc04_services: Join multiline dereferences
  staging: vc04_services: Unsplit user-visible strings
  staging: vc04_services: Use __func__

 .../vc04_services/bcm2835-camera/bcm2835-camera.c  | 23 +++++++++-------------
 .../vc04_services/bcm2835-camera/mmal-vchiq.c      |  7 +++----
 2 files changed, 12 insertions(+), 18 deletions(-)

--
2.15.1
