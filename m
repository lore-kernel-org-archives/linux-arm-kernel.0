From: d.lavnikevich@sam-solutions.com (Dmitry Lavnikevich)
Date: Fri, 3 Oct 2014 16:18:52 +0300
Subject: [PATCH v4 0/4] Add Phytec pbab01 audio support
In-Reply-To: <1410854903-26419-1-git-send-email-d.lavnikevich@sam-solutions.com>
References: <1410854903-26419-1-git-send-email-d.lavnikevich@sam-solutions.com>
Message-ID: <1412342336-25700-1-git-send-email-d.lavnikevich@sam-solutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

New phyFLEX board audio patchset version.

Small changes made since last version:

- removed unnecessary 'regulator-always-on' in fixed regulators dts
  description;
- removed 'fsl,mode = "i2s-slave"' from ssi2 node in dts since it was
  already removed from fsl-ssi driver.

Based on branch for-next from
git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
