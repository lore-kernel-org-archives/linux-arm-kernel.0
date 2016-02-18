From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 18 Feb 2016 22:23:07 +0800
Subject: [PATCH v3 1/3] ARM: dts: vf-colibri: remove regulator container
 node
In-Reply-To: <1455752460-2770-1-git-send-email-stefan@agner.ch>
References: <1455752460-2770-1-git-send-email-stefan@agner.ch>
Message-ID: <20160218142307.GA6756@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2016 at 03:40:58PM -0800, Stefan Agner wrote:
> Drop the fake simple-bus container 'regulators' and put the
> regulators directly under the root node. This also makes the
> artificial 'reg' properties superfluous. While at it, remove
> the unnecessary regulator-always-on property and name the
> regulators according to schematics.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Changes since v2:
> - remove regulator-always-on
> 
> Changes since v1:
> - rename regulators according to schematics
> - drop sys prefix

Okay.  Replaced v1 with v3.

Shawn
