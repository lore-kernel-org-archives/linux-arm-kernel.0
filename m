From: stanley.miao@windriver.com (Stanley.Miao)
Date: Mon, 17 Jan 2011 16:42:06 +0800
Subject: [PATCH 0/3] Support BE8 kernel modules relocation
Message-ID: <1295253729-23153-1-git-send-email-stanley.miao@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first patch is to solve the BE8 kernel modules relocation problems.

The second patch is to support BE8 kernel on a little-endian machine.

The third patch is to add some debug macros to help the developer to location the boot problems.

In order to test the first patch, I am sure some people will need the other two patches, so I send them together.

Stanley.
