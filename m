From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Mon, 22 Nov 2010 12:10:17 +0200
Subject: [PATCH v4 1/2] MMC: add support for the Marvell Dove SDHCI
	controller
In-Reply-To: <AANLkTimhzUe+qODZYCvvrH6Hi06gV1yHVpS1LRHhXu7o@mail.gmail.com>
References: <cover.1288293593.git.mike@compulab.co.il>
	<ea487c43c1aff1d07355e0e0699e739c8617b96f.1288293593.git.mike@compulab.co.il>
	<AANLkTimhzUe+qODZYCvvrH6Hi06gV1yHVpS1LRHhXu7o@mail.gmail.com>
Message-ID: <AANLkTin66iEqCgUKUFXGLZg4pu-mv=zb-E+x04BrC-=h@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 22, 2010 at 9:42 AM, saeed bishara <saeed.bishara@gmail.com> wrote:
> On Thu, Oct 28, 2010 at 9:23 PM, Mike Rapoport <mike@compulab.co.il> wrote:
...
>> + ? ? ? bool "SDHCI support on Marvell's Dove SoC"
...
>> + ? ? ? ? If you have a controller with this interface, say Y or M here.

Just a nitpick:  I guess that the "or M" in "say Y or M" is a typo
