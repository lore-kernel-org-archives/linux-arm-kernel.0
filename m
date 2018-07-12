From: tony@atomide.com (Tony Lindgren)
Date: Wed, 11 Jul 2018 22:26:27 -0700
Subject: [PATCH -next] pinctrl: single: Fix missing unlock on error path
In-Reply-To: <1531312411-134133-1-git-send-email-weiyongjun1@huawei.com>
References: <1531312411-134133-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <20180712052627.GO99251@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Wei Yongjun <weiyongjun1@huawei.com> [180711 12:27]:
> Add the missing unlock before return from function
> in the error handling case.

Oops yes sorry about that and thanks for fixing it:

Acked-by: Tony Lindgren <tony@atomide.com>
