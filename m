From: snjw23@gmail.com (Sylwester Nawrocki)
Date: Wed, 26 Jan 2011 21:52:55 +0900
Subject: [PATCH] ARM: S5PV210: Add GONI board setup for CIF camera support
In-Reply-To: <1294419468-13700-1-git-send-email-s.nawrocki@samsung.com>
References: <1294419468-13700-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <4D401927.6040005@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 01/08/2011 01:57 AM, Sylwester Nawrocki wrote:
> Hello,
>
> the following patch series introduces changes in GONI board setup file
> required for the CIF camera sensor driver.
> The first patch adds the I2C0 bus driver, the second one adds the regulator
> supply definitions and the third one just increases virtual size
> of the framebuffer window 0 for preview double buffering.
>
>
> The patch series contains:
>
> [PATCH 1/3] ARM: S5PV210: Enable I2C0 bus on GONI board
> [PATCH 2/3] ARM: S5PV210: Add supplies for CIF camera on GONI board
> [PATCH 3/3] ARM: S5PV210: Change framebuffer window 0 size on GONI
>
> Created against kgene-for-next branch at:
> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
>

Any comments about these patches?

Regards,
Sylwester
