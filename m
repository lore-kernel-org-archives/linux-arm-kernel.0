From: javier.martin@vista-silicon.com (Javier Martin)
Date: Fri,  6 Jul 2012 14:57:48 +0200
Subject: [PATCH 0/3] Add support for 'Coda' video codec IP.
Message-ID: <1341579471-25208-1-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provides support for the codadx6 that is inside
the i.MX27. Currently only H.264 and MPEG4 Part-2 encoding
operations are supported.

This is a refined version of the RFC sent two weeks ago [1].
The following tasks have been addressed since then:
 - Get rid of 'runtime' structure.
 - Device tree support (not tested).
 - Merge all the code in a single source file.
 - Use one node for both encoding and decoding.
 - Multi-instance support (not tested for more than one instance).
 - Prepare the code so that integration of further coda versions is easier.

This patch takes into account recommendations from Sascha and Philipp
from Pengutronix.

[PATCH 1/3] i.MX: coda: Add platform support for coda in i.MX27.
[PATCH 2/3] media: coda: Add driver for Coda video codec.
[PATCH 3/3] Visstrim M10: Add support for Coda.


[1] http://patchwork.linuxtv.org/patch/12977/
