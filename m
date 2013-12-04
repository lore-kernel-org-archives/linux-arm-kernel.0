From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 4 Dec 2013 09:56:41 +0100
Subject: [PATCH 03/31] ARM: tegra: document use of standard DMA DT bindings
In-Reply-To: <529E2867.6090209@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-4-git-send-email-swarren@wwwdotorg.org>
 <20131129122907.GP22771@ulmo.nvidia.com>
 <529E2867.6090209@wwwdotorg.org>
Message-ID: <20131204085640.GI19943@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 11:52:23AM -0700, Stephen Warren wrote:
> On 11/29/2013 05:29 AM, Thierry Reding wrote:
> > On Fri, Nov 15, 2013 at 01:53:58PM -0700, Stephen Warren wrote:
> 
> >> diff --git
> >> a/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt
> >> b/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt
> 
> >>
> >> 
> - ranges : The bus address mapping for the configlink register bus.
> >> +- dmas : Must contain an entry for each entry in clock-names. +
> >> See ../dma/dma.txt for details. +- dma-names : Must include the
> >> following entries: +  - rx0 .. rx<n> +  - tx0 .. tx<n> +  ...
> >> where n is: +  Tegra30: 3 +  Tegra114, Tegra124: 9 Can be empty
> >> since the mapping is 1:1.
> > 
> > I think this line belongs to the description of the "ranges"
> > property.
> 
> Yes, I've fixed that up locally simply by moving the inserted lines 1
> line lower. I assume you don't want a repost for that?

No need for a repost.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131204/c2833b07/attachment.sig>
