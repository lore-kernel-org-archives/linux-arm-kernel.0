From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 19 May 2015 12:54:06 +0800
Subject: [PATCH] vf610: dt: Nomenclature fixup for PTC12 pin used in RMII
 mode.
In-Reply-To: <1431573098-23809-1-git-send-email-cory.tusar@pid1solutions.com>
References: <1431573098-23809-1-git-send-email-cory.tusar@pid1solutions.com>
Message-ID: <20150519045406.GM1071@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 11:11:38PM -0400, Cory Tusar wrote:
> This commit includes a minor nomenclature fixup for boards based on the
> Freescale VF610 SoC and which make use of the alternate "RMII1_RXD1"
> functionality for pin PTC12.  This brings the macro name in-line with
> both the datasheet and other similar macros.
> 
> Signed-off-by: Cory Tusar <cory.tusar@pid1solutions.com>

Change patch prefix to 'ARM: dts: vf610: ', and applied.

Shawn
