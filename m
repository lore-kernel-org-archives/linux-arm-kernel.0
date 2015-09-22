From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Tue, 22 Sep 2015 15:34:28 +0300
Subject: net: thunderx: Support for upto 96 queues for a VF
In-Reply-To: <CY1PR0701MB16613A356BAAB39BB3593F7893460@CY1PR0701MB1661.namprd07.prod.outlook.com>
References: <20150921163118.GG5648@mwanda>
 <CY1PR0701MB16613A356BAAB39BB3593F7893460@CY1PR0701MB1661.namprd07.prod.outlook.com>
Message-ID: <20150922123428.GT5004@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Actually since this is a false positive, maybe just ignore the warning?

I should have been more careful when I sent the email.  The static
checker often has false positives here if the modification happens in a
different thread.

regards,
dan carpenter
