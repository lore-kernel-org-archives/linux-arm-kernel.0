From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 22 Apr 2014 10:15:09 +0200
Subject: [RFC PATCH 00/11] Embeddable Position Independent Executable
In-Reply-To: <201310241009.12597.heiko@sntech.de>
References: <1379421817-15759-1-git-send-email-Russ.Dill@ti.com>
 <201310241009.12597.heiko@sntech.de>
Message-ID: <1441820.DP5PYDOd2T@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russ,

Am Donnerstag, 24. Oktober 2013, 10:09:12 schrieb Heiko St?bner:
> Am Dienstag, 17. September 2013, 14:43:26 schrieb Russ Dill:
> > This patch adds support for and demonstrates the usage of an embedded
> > position independent executable (PIE). The goal is to allow the use of C
> > code in situations where carefully written position independent assembly
> > was previously required.
> 
> As suggested yesterday evening by Kevin Hilman, just adding my 2ct of
> support.
> 
> This series looks exactly like the foundation I'll need at some point in the
> (probably still distant) future to handle suspend on my Rockchip platform -
> where like in your example stuff like putting the ram into selfrefresh has
> to be done by the os.

just as it came up recently again for me and I couldn't find any newer version, 
ist this series still on the table?


Thanks
Heiko
