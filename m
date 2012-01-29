From: marc@cpdesign.com.au (Marc Reilly)
Date: Mon, 30 Jan 2012 09:51:00 +1100
Subject: mc13892 touchscreen support
Message-ID: <1327877464-23526-1-git-send-email-marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series adds touchscreen support for the mc13892 to the
mc13873 driver. The driver is renamed to mc13xxx_ts to reflect this.

The first 3 patches apply cleanly to v3.2.

The fourth patch allows setting the ATO and ATOX registers with each
conversion. It requires another series I just posted [1].

Cheers,
Marc

[1] http://lists.arm.linux.org.uk/lurker/message/20120129.223322.722b7424.en.html
