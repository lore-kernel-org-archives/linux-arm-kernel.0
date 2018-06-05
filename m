From: richardcochran@gmail.com (Richard Cochran)
Date: Tue, 5 Jun 2018 06:57:49 -0700
Subject: [PATCH 09/10] dpaa_eth: add support for hardware timestamping
In-Reply-To: <DB6PR0401MB2536376432EC481473A5B4A3F8660@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <20180604070837.19265-1-yangbo.lu@nxp.com>
 <20180604070837.19265-10-yangbo.lu@nxp.com>
 <20180604134920.ezhe6jz5ntpnqyzj@localhost>
 <DB6PR0401MB2536376432EC481473A5B4A3F8660@DB6PR0401MB2536.eurprd04.prod.outlook.com>
Message-ID: <20180605135748.mlarwiyzf2oe27ax@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 05, 2018 at 03:35:28AM +0000, Y.b. Lu wrote:
> [Y.b. Lu] Actually these timestamping codes affected DPAA networking performance in our previous performance test.
> That's why we used ifdef for it.

How much does time stamping hurt performance?

If the time stamping is compiled in but not enabled at run time, does
it still affect performace?

Thanks,
Richard
