From: myungjoo.ham@samsung.com (=?UTF-8?B?TXl1bmdKb28gSGFt?=)
Date: Wed, 06 Jul 2016 02:38:01 +0000
Subject: =?UTF-8?B?UkU6IFtQQVRDSCA2LzddIGRldmZyZXE6IGFkZCBtaXNzaW5n?=
 =?UTF-8?B?IG9mX25vZGVfcHV0IGFmdGVyIGNhbGxpbmcgb2ZfcGFyc2Vf?=
 =?UTF-8?B?cGhhbmRsZQ==?=
References: <1467366121-14120-1-git-send-email-peter.chen@nxp.com>
 <CGME20160701094923epcas1p164cc8773ec44a00dfc506a6192df3409@epcas1p1.samsung.com>
Message-ID: <1979940416.433337.1467772681910.JavaMail.weblogic@ep2ml104d>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> --------- Original Message ---------
> Sender : Peter Chen <peter.chen@nxp.com>
> Date   : 2016-07-01 18:49 (GMT+9)
> Title  : [PATCH 6/7] devfreq: add missing of_node_put after calling of_parse_phandle
>  
> of_node_put needs to be called when the device node which is got
> from of_parse_phandle has finished using.
>  
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Peter Chen <peter.chen@nxp.com>

Thank you!


Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
