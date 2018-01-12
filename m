From: olof@lixom.net (Olof Johansson)
Date: Thu, 11 Jan 2018 18:07:46 -0800
Subject: [PATCH 3/3] arm: spear13xx: Fix spics gpio controller's warning
In-Reply-To: <9d8521e3990be6789f1ed3d5757b57c65483117b.1515650104.git.viresh.kumar@linaro.org>
References: <a062d9ed0d3365b578156a780202fa533e725374.1515650104.git.viresh.kumar@linaro.org>
 <9d8521e3990be6789f1ed3d5757b57c65483117b.1515650104.git.viresh.kumar@linaro.org>
Message-ID: <20180112020746.bbprwgp5cgevwjyq@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 11, 2018 at 11:28:53AM +0530, Viresh Kumar wrote:
> This fixes the following warning by also sending the flags argument for
> gpio controllers:
> 
> Property 'cs-gpios', cell 6 is not a phandle reference in
> /ahb/apb/spi at e0100000
> 
> Fixes: 8113ba917dfa ("ARM: SPEAr: DT: Update device nodes")
> Cc: stable at vger.kernel.org # v3.8+
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---


Applied to next/dt.


-Olof
