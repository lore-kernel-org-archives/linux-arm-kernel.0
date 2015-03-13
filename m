From: sebastien.szymanski@armadeus.com (=?windows-1252?Q?S=E9bastien_Szymanski?=)
Date: Fri, 13 Mar 2015 17:11:46 +0100
Subject: [PATCH v6 0/6] wlcore: add device-tree support
In-Reply-To: <1426162154-8716-1-git-send-email-eliad@wizery.com>
References: <1426162154-8716-1-git-send-email-eliad@wizery.com>
Message-ID: <55030C42.6020206@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 03/12/2015 01:09 PM, Eliad Peller wrote:
> 
> NOTE: all the platform patches were compile-tested
> only. I'm looking for some wl12xx card (that i should
> have somewhere) to test the wl12xx changes (wrt. clocks),
> but haven't found it yet.
> 

I have tested this series on a APF6 board, i.MX6 based board with a
Jorjin WG7311-0A Wifi/BT module which is based on the wl1271l.

It works. I was able to power up the wlan0 interface and ping google.

Best regards,

-- 
S?bastien Szymanski
