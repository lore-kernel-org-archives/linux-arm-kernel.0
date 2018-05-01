From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 1 May 2018 16:22:29 +0530
Subject: [PATCH v6 0/7] ARM: davinci: complete the conversion to using the
 reset framework
In-Reply-To: <20180417173038.25510-1-brgl@bgdev.pl>
References: <20180417173038.25510-1-brgl@bgdev.pl>
Message-ID: <08106d9b-6350-9aa1-9c58-50dd0aaf690c@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartosz,

On Tuesday 17 April 2018 11:00 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This series converts the only user of the handcoded, mach-specific reset
> routines in the davinci platform to using the reset framework.
> 
> Patches 1-2 add necessary lookups/DT-properties.
> 
> Patches 3-5 fix issues found in the remoteproc davinci driver.
> 
> Patch 6 converts the davinci-rproc driver to the reset framework.
> 
> Patch 7 removes now dead code.
> 
> Tested both in DT and legacy modes by booting the examples from
> ti-ipc-rtos recipe in meta-ti.
> 
> This series applies on top of David Lechner's common-clk-v9 branch[1].

To make it easier for Bjorn to apply his patches, can you please
separate out the remoteproc parts which are safe to apply to v4.17-rc1
and repost the series? Please collect the reviews and acks too.

Thanks,
Sekhar
