From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Feb 2016 12:54:06 +0100
Subject: [PATCH 2/3] serial: xuartps: Enable OF earlycon support
In-Reply-To: <23ab10a19b21df2ef17a5bb6ce2a70d2d3fd3551.1455552315.git.michal.simek@xilinx.com>
References: <67c9013fc61f53515934b54847a05df8b8e1504a.1455552315.git.michal.simek@xilinx.com>
 <23ab10a19b21df2ef17a5bb6ce2a70d2d3fd3551.1455552315.git.michal.simek@xilinx.com>
Message-ID: <7244827.meF4e5ZIpB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 February 2016 17:05:18 Michal Simek wrote:
> Support early console setup via DT for all listed compatible strings.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 

I'd suggest we take the whole series through arm-soc, as the third patch
depends on this second one.

Greg, is this ok for you?

	Arnd
