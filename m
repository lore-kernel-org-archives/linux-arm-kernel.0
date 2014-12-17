From: xerofoify@gmail.com (nick)
Date: Wed, 17 Dec 2014 17:57:24 -0500
Subject: Weird/Unneeded call to msleep in exynos_mipi_dsi_wr_data in
 exynos_mipi_dsi_common.c
Message-ID: <54920A54.2060608@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings Fellow Maintainers,
Sorry if I wasting your time but it seems there is a unneeded call to msleep and rather trivial fix me to fix in the file,exynos_mipi_dsi_common.c for the function,exynos_mipi_dsi_wr_data . If there is a valid reason for this call please let me known when any of you  have some free time. Otherwise I will send in a patch to remove this unneeded
call to msleep.
Thanks,
Nick  
