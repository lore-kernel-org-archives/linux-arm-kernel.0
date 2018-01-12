From: olof@lixom.net (Olof Johansson)
Date: Thu, 11 Jan 2018 18:07:35 -0800
Subject: [PATCH 2/3] arm: spear13xx: Fix dmas cells
In-Reply-To: <6183c13fd3abcb2a6834a537a4809b6527204f10.1515650104.git.viresh.kumar@linaro.org>
References: <a062d9ed0d3365b578156a780202fa533e725374.1515650104.git.viresh.kumar@linaro.org>
 <6183c13fd3abcb2a6834a537a4809b6527204f10.1515650104.git.viresh.kumar@linaro.org>
Message-ID: <20180112020735.67vndge2vfy6rtpk@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 11, 2018 at 11:28:52AM +0530, Viresh Kumar wrote:
> The "dmas" cells for the designware DMA controller need to have only 3
> properties apart from the phandle: request line, src master and
> destination master. But the commit 6e8887f60f60 updated it incorrectly
> while moving from platform code to DT. Fix it.
> 
> Cc: stable at vger.kernel.org # v3.10+
> Fixes: 6e8887f60f60 ("ARM: SPEAr13xx: Pass generic DW DMAC platform data from DT")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied to next/dt.


-Olof
