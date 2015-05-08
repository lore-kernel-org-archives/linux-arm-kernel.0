From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 8 May 2015 11:47:54 -0700
Subject: [PATCH] ARM: tegra: add "nor-jedec" flash compatible binding
In-Reply-To: <20150508184317.GZ32500@ld-irv-0074>
References: <1431066098-19821-1-git-send-email-zajec5@gmail.com>
 <554CDD8C.7050000@wwwdotorg.org>
 <20150508184317.GZ32500@ld-irv-0074>
Message-ID: <20150508184754.GA32500@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 11:43:17AM -0700, Brian Norris wrote:
> I'm open to change, as this binding is new in 4.1-rc1.

Though we'd need to make sure any change to "nor-jedec" gets applied to
the shmobile platforms that have started using this string in
linux-next.

Brian
