From: Alexander.Levin@microsoft.com (Sasha Levin)
Date: Tue, 10 Apr 2018 13:50:38 +0000
Subject: [PATCH v5 2/3] ARM: ftrace/recordmcount: filter relocation types
In-Reply-To: <20180406143939.14642-3-alexander.sverdlin@nokia.com>
References: <20180406143939.14642-3-alexander.sverdlin@nokia.com>
Message-ID: <DM5PR2101MB1032EF6B16414765AA0BAB19FBBE0@DM5PR2101MB1032.namprd21.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[This is an automated email]

This commit has been processed by the -stable helper bot and determined
to be a high probability candidate for -stable trees. (score: 46.9374)

The bot has tested the following trees: v4.16.1, v4.15.16, v4.14.33, v4.9.93, v4.4.127.

v4.16.1: Build OK!
v4.15.16: Build OK!
v4.14.33: Build OK!
v4.9.93: Failed to apply! Possible dependencies:
    9648dc15772d ("recordmcount: arm: Implement make_nop")

v4.4.127: Failed to apply! Possible dependencies:
    9648dc15772d ("recordmcount: arm: Implement make_nop")


Please let us know if you'd like to have this patch included in a stable tree.

--
Thanks,
Sasha
