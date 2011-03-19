From: richardcochran@gmail.com (Richard Cochran)
Date: Sat, 19 Mar 2011 11:14:12 +0100
Subject: [PATCH V12 0/4] ptp: IEEE 1588 hardware clock support
In-Reply-To: <cover.1298878618.git.richard.cochran@omicron.at>
References: <cover.1298878618.git.richard.cochran@omicron.at>
Message-ID: <20110319101412.GA14207@riccoc20.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For all those interested in the user space aspect, I have posted some
patches to ptpd project showing how the API works.

https://sourceforge.net/tracker/?group_id=139814&atid=744634

3225599 [PATCH 1/3] Convert to POSIX clock API.
3225603 [PATCH 2/3] Adapted to use the Linux PTP Hardware Clock API.
3225607 [PATCH 3/3] Adapted to use the newer SO_TIMESTAMPING Linux API.

Enjoy,

Richard
