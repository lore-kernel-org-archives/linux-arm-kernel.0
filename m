From: d.lavnikevich@sam-solutions.com (Dmitry Lavnikevich)
Date: Wed, 10 Sep 2014 16:46:44 +0300
Subject: [PATCH 0/5] Add Phytec pbab01 audio support
Message-ID: <1410356809-26179-1-git-send-email-d.lavnikevich@sam-solutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset implements audio support on Phytec's phyFLEX-i.MX6
boards. This includes creating imx-tlv320aic3x machine driver, fixing
tlv320aic3x driver playback speed issue and enabling audio for pbab01
itself.
