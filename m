From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 31 Dec 2013 22:30:39 +0100
Subject: [GIT PULL] ARM : cpuidle: 3.13 fix
In-Reply-To: <52C15268.4050403@linaro.org>
References: <52C15268.4050403@linaro.org>
Message-ID: <4735745.5h2OjxOOl8@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, December 30, 2013 12:00:56 PM Daniel Lezcano wrote:
> Hi Rafael,
> 
> this pull request provides a single fix for the calxeda cpuidle driver. 
> It is based on v3.13-rc6.
> 
> * Andre Przywara fixed a compilation warning due to the driver probe 
> function prototype mismatch for the calxeda cpuidle driver
> 
> Thanks
>    -- Daniel
> 
> The following changes since commit 802eee95bde72fd0cd0f3a5b2098375a487d1eda:
> 
>    Linux 3.13-rc6 (2013-12-29 16:01:33 -0800)
> 
> are available in the git repository at:
> 
>    git://git.linaro.org/people/daniel.lezcano/linux.git cpuidle/3.13-fixes
> 
> for you to fetch changes up to 5781532ebecd9e0b7b5fc25d78030bdec635f4ac:
> 
>    ARM/cpuidle: remove __init tag from Calxeda cpuidle probe function 
> (2013-12-30 11:55:20 +0100)
> 
> ----------------------------------------------------------------
> Andre Przywara (1):
>        ARM/cpuidle: remove __init tag from Calxeda cpuidle probe function
> 
>   drivers/cpuidle/cpuidle-calxeda.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Pulled and pushed out (into the fixes branch).

Thanks and Happy New Year!

Rafael
