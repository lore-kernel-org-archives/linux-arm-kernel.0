From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 4 Mar 2011 12:40:42 +0000
Subject: [PATCH] Exynos4: Remove meaningless REGULATOR config option
In-Reply-To: <4D70D295.7030101@ru.mvista.com>
References: <20110304051609.GA15121@july> <4D70D295.7030101@ru.mvista.com>
Message-ID: <20110304124041.GD17653@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 04, 2011 at 02:52:53PM +0300, Sergei Shtylyov wrote:
> On 04-03-2011 8:16, Kyungmin Park wrote:

>> From: Kyungmin Park<kyungmin.park@samsung.com>

>> reguration APIs are guarded at its header file

>    Regulation?

>> No need to define at codes.

>    Can't understand this.

The regulator API ifdefs itself out when not enabled so there is no need
for users to do this.
