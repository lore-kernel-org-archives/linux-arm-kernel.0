From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 12 Aug 2013 09:44:37 -0600
Subject: [PATCH v3] ARM: DT: binding fixup to align with
 vendor-prefixes.txt
In-Reply-To: <1376165636-14654-1-git-send-email-csd@broadcom.com>
References: <1376165636-14654-1-git-send-email-csd@broadcom.com>
Message-ID: <520902E5.8030009@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2013 02:13 PM, Christian Daudt wrote:
> [ this is a follow-up to this discussion:
> http://archive.arm.linux.org.uk/lurker/message/20130730.230827.a1ceb12a.en.html ]
> This patchset renames all uses of "bcm," name bindings to
> "brcm," as they were done prior to knowing that brcm had
> already been standardized as Broadcom vendor prefix
> (in Documentation/devicetree/bindings/vendor-prefixes.txt).
> This will not cause any churn on devices because none of
> these bindings have made it into production yet.
> Also rename the the following dt binding docs that had "bcm,"
> in their name for consistency:
>  - bcm,kona-sdhci.txt -> kona-sdhci.txt
>  - bcm,kona-timer.txt -> kona-timer.txt

Acked-by: Stephen Warren <swarren@nvidia.com>
