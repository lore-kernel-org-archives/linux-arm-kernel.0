From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Mon, 17 Jul 2017 11:02:21 +0300
Subject: [PATCH] pinctrl: zte: fix 'functions' allocation in
 zx_pinctrl_build_state()
In-Reply-To: <1500212008-29321-1-git-send-email-shawnguo@kernel.org>
References: <1500212008-29321-1-git-send-email-shawnguo@kernel.org>
Message-ID: <20170717080221.gqf7xgeo2zqgigdq@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shouldn't there be a free if the remove function?  I'm not even sure
where the remove function is so I don't know.

regards,
dan carpenter
