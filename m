From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Fri, 19 Feb 2016 13:15:05 +0300
Subject: [PATCH] staging: rtl8712: reduce stack usage
In-Reply-To: <1455698012-814399-1-git-send-email-arnd@arndb.de>
References: <1455698012-814399-1-git-send-email-arnd@arndb.de>
Message-ID: <20160219101505.GO32153@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Of course, we still reach almost the same maximum stack usage as before
because we're going to put the function on stack in the end anyway.

regards,
dan carpenter
