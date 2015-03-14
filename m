From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 14 Mar 2015 22:22:39 +0100
Subject: [PATCH 04/10] ARM: zx: add initial L2CC initialization
In-Reply-To: <1426333785-3952-5-git-send-email-jun.nie@linaro.org>
References: <1426333785-3952-1-git-send-email-jun.nie@linaro.org>
 <1426333785-3952-5-git-send-email-jun.nie@linaro.org>
Message-ID: <2075202.63nIomtdeh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 14 March 2015 19:49:39 Jun Nie wrote:
> Add an initial L2 Cache controller initialization.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> 

This should not be needed at all, we expect all platforms
to describe the l2 cache controller in DT to the degree
that is required to have it probed automatically.

Is there any special requirement about this platform that
makes this impossible?

	Arnd
