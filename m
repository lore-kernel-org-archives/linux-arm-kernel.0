From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 4 Jan 2011 20:20:52 +0000
Subject: [RFC 0/5] runtime P2V translations
Message-ID: <20110104202052.GE24935@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's my solution to this, which should allow it to be used on almost
all platforms, including MSM, with the exception of Realview when
SPARSEMEM is enabled.
