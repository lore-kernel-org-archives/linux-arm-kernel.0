From: nikita.yoush@cogentembedded.com (Nikita Yushchenko)
Date: Wed, 21 Dec 2016 15:58:45 +0300
Subject: [v4,
 3/3] ARM: dts: vf610-zii-dev-rev-b: Remove 'fixed-link' from DSA ports
In-Reply-To: <1482131877-6097-3-git-send-email-andrew.smirnov@gmail.com>
References: <1482131877-6097-3-git-send-email-andrew.smirnov@gmail.com>
Message-ID: <1482325125-15725-1-git-send-email-nikita.yoush@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Remove 'fixed-link' nodes from DSA ports since they are not needed (they
> are not limiting link's speed and the ports will be configured to their
> maximux speed as a default)
>
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

With this patch, ports connected to revB's second switch stop working.

Nikita
