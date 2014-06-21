From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 21 Jun 2014 12:54:25 +0800
Subject: [PATCH 1/3] ARM: dts: mbimxsd25: cmo-qvga: Fix lcd regulator
In-Reply-To: <1403001999-12316-1-git-send-email-denis@eukrea.com>
References: <1403001999-12316-1-git-send-email-denis@eukrea.com>
Message-ID: <20140621045423.GC6818@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 12:46:37PM +0200, Denis Carikli wrote:
> The fixed-regulator's enable-active-high property
> is needed to indicate that the GPIO regulator is
> active high.
> 
> Before that the regulator state was inverted.
> 
> Signed-off-by: Denis Carikli <denis@eukrea.com>

Applied this one, thanks.
